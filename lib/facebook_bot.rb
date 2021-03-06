# coding: utf-8

require 'rubygems'
require 'mechanize'
#include WWW
require 'uri'
require 'cgi'
require 'time'
require 'json'

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
  end

	def video_url(id)
    load_video_page(id)
    get_url(@video_page)
  #rescue
  #  VIDEO_ERROR
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

	def get_url(page)
    url ||= extract_url_hd(page)
    url ||= extract_url_sd(page)
    url ||= extract_url_old(page)
    url.nil? ? raise(RuntimeError) : url
	end

  def get_name(site)
    name = site.scan(/title>(.+)<\/title>/ix).first
    name ? name.first : VIDEO_ERROR
  end

  def extract_url_old(url)
		url = url.scan(/\[\"highqual_src\",\"(.+)\"\]/ix).first
    url = url.first
		url = url.gsub('\u00253A', ':')
		url = url.gsub('\u00252F', '/')
		url = url.gsub('\u00253F', '?')
		url = url.gsub('\u00253D', '=')
		url = url.gsub('\u002526', '&')
    url = url.gsub('\u00255C', '\\')
		url = "http://#{url.split('http://')[1]}".split('"').first
		CGI.unescapeHTML(url)
  rescue
    nil
  end

  def extract_url_hd(page)
    url = page.scan(/hd_src.*?((http.*?)(\.mp4).*?(\\u002522))/ix).last.first
    URI.decode(JSON('["'+url+'"]').first).gsub('\\', '').gsub('"', '')
  rescue
    nil
  end

  def extract_url_sd(page)
    url = page.scan(/sd_src.*?((http.*?)(\.mp4).*?(\\u002522))/ix).last.first
    URI.decode(JSON('["'+url+'"]').first).gsub('\\', '').gsub('"', '')
  rescue
    nil
  end

end
