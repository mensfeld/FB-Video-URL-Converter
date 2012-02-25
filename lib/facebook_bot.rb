# coding: utf-8

require 'rubygems'
require 'mechanize'
#include WWW
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
      @@root = self.class.cookie_path
    end

    @cookies = File.join(@@root, "cookie_#{self.class.email}.yml")

    begin
      @agent.cookie_jar.load(@cookies)
    rescue
    end if (File.file?(@cookies) && File.size(@cookies) > 10)

    self.login
  end

  def login
    page = @agent.get(FB_URL)

    if (loginf = page.form_with(:id => "login_form"))
      loginf.set_fields(:email => self.class.email, :pass => self.class.password)

      page = @agent.submit(loginf, loginf.buttons.first)
    end
    
    @agent.cookie_jar.save_as(@cookies)

    body = page.root.to_html
    @post_form_id = %r{<input type="hidden" .* name="post_form_id" value="([^"]+)}.match(body)[1]
    if body.include?('Incorrect Email')
      raise self.class::LoginFailed, 'Incorrect login/password or cookie corrupted'
    end
  rescue
    @agent.cookie_jar.clear!
    @agent.cookie_jar.save_as(@cookies)
    raise self.class::LoginFailed, 'Incorrect login/password or cookie corrupted'
  end

	def video_url(id)
    load_video_page(id)
    get_url(@video_page)
  rescue
    VIDEO_ERROR
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
		url = url.scan(/\[\"highqual_src\",\"(.+)\"\]/ix).first
    url = url.first
		url = url.split(')').first.gsub('\u00253A', ':')
		url = url.gsub('\u00252F', '/')
		url = url.gsub('\u00253F', '?')
		url = url.gsub('\u00253D', '=')
		url = url.gsub('\u002526', '&')
		url = "http://#{url.split('http://')[1]}".split('"').first
		CGI.unescapeHTML(url)
	end

  def get_name(site)
    name = site.scan(/title>(.+)<\/title>/ix).first
    name ? name.first : VIDEO_ERROR
  end

end
