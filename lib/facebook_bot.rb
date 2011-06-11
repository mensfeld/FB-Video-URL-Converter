# coding: utf-8

require 'rubygems'
require 'mechanize'
include WWW
require 'uri'
require 'cgi'
require 'time'

class Mechanize::Page
  def form_id(formId)
    formcontents = (self/:form).find { |elem| elem['id'] == formId }
    if formcontents then return Mechanize::Form.new(formcontents) end
  end
end

class FacebookBot

  # Probably wrong login || password
  class LoginFailed               < StandardError; end
  class CookiePathNotInitialized  < StandardError; end

  class << self
    attr_accessor :email
    attr_accessor :password
    attr_accessor :cookie_path
  end

  FB_URL        = "http://www.facebook.com/"
  USER_AGENT    = 'Windows IE 7'
  VIDEO_ERROR   = 'video_id_error'


  def initialize
    @video_page = nil
    @agent = Mechanize.new
    @agent.user_agent_alias = USER_AGENT

    begin
      @@root = File.join(Rails.root, 'tmp')
    rescue
      raise CookiePathNotInitialized, 'Specify cookie_path' if self.class.cookie_path.nil?
      # @@root = File.expand_path(File.dirname(__FILE__))
      @@root = self.class.cookie_path
    end

    @cookies = File.join(@@root, "cookie_#{self.class.email}.yml")

    begin
      @agent.cookie_jar.load(@cookies)
    rescue
      @agent.cookie_jar.clear!
    end if (File.file?(@cookies) && File.size(@cookies) > 10)

    self.login
  end

  def login
    page = @agent.get(FB_URL)

    if (loginf = page.form_id("login_form"))
      loginf.set_fields(:email => self.class.email, :pass => self.class.password)
      page = @agent.submit(loginf, loginf.buttons.first)
      # When we login (successfully) we will be redirected in a not so "gracefull"
      # way - so we need to "skip" redirecting page
      page = @agent.get(FB_URL) if page.root.to_html.include?('<title>Redirecting')
    end

    @agent.cookie_jar.save_as(@cookies)
    body = page.root.to_html

    begin
      # This is a UID given to each Facebook user.
      @uid = %r{\\"user\\":(\d+),\\"hide\\"}.match(body)[1]
    rescue
      @uid = nil
    end

    # This is a token we need to submit forms.
    begin
      @post_form_id = %r{<input type="hidden" .* name="post_form_id" value="([^"]+)}.match(body)[1]
    rescue
      raise self.class::LoginFailed, 'Incorrect login or password'
    end
  end

	def video_url(id)
    begin
      load_video_page(id)
      get_url(@video_page)
    rescue
      VIDEO_ERROR
    end
	end

  def video_name(id)
    load_video_page(id)
    get_name(@video_page)
  end

	private

  def load_video_page(id)
    if @video_page.nil?
      pa = @agent.get("#{FB_URL}video/video.php?v=#{id}")
      @video_page = pa.body
    end
  end

	def get_url(url)
		url = url.scan(/addVariable\(\"highqual_src\",\s\"http.+\"\)/ix).first
		url = url.split(')').first.gsub('\u00253A', ':')
		url = url.gsub('\u00252F', '/')
		url = url.gsub('\u00253F', '?')
		url = url.gsub('\u00253D', '=')
		url = url.gsub('\u002526', '&')
		url = "http://#{url.split('http://')[1]}".split('"').first
		CGI.unescapeHTML(url)
	end

  def get_name(site)
    name = site.scan(/datawrap\">(.+)<\/h3>/ix).first
    name ? name.first : VIDEO_ERROR
  end

end
