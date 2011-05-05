# Copyright © 2011 Maciej Mensfeld, released under the MIT license

require 'net/http'
require 'uri'
require 'active_record'

# Small extension to determine if string is a number
class String
  def is_number?
    self.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
end

class FacebookVideo < ActiveRecord::Base

  attr_accessor :error

  class << self
    attr_accessor :cache
  end

  VIDEO_ERROR_MSG = :video_id_error
  FB_ERROR_MSG = :fb_account_error

  # Dummy video object containing info about error
  # We will not return (or raise) errors - it is not deseable
  class NotWorkingVideo

    attr_accessor :error

    def initialize(error)
      @error = error
    end
    
    def url
      @error
    end

    def name
      @error
    end

    def working?
      false
    end
    
  end

  before_create :set_cached_at_time

  validates_uniqueness_of :video_id
  validate :working?

  def self.get(v_id)
    v = self.video_data(v_id)
    case v
      when 'video_error' then NotWorkingVideo.new(VIDEO_ERROR_MSG)
      when 'fb_error' then NotWorkingVideo.new(FB_ERROR_MSG)
      else v
    end
  end

  def url=(new_url)
    self.errors.clear
    self.cached_at = Time.now
    super new_url
  end

  def working?
    v = false
    if self.cached_at >= Time.now - self.class.cache && self.url.length > 10
      v = true
    else
      v = url_working?
      self.cached_at = Time.now
    end
    self.errors.add(:cached_at, 'Cache ulegl przedawnieniu') unless v
    v
  end

  def url_working?
    begin
      host = URI.parse(self.url).host
      http = Net::HTTP.new(host)
      headers = http.head(self.url)
    rescue
      return true
    end
    if headers.code == "200"
      true
    else
      false
    end
  end

  private

  def self.video_data(v_id)
    unless v_id.to_s.is_number?
      v_id = v_id.scan(/[0-9]+/).first
    end

    return 'video_error' if v_id.nil? || v_id.length < 12

    video = self.find_by_video_id(v_id)
    unless video && video.valid?
      begin
        fb = FacebookBot.new
      rescue
        return 'fb_error'
      end
      url = fb.video_url(v_id)
      name = fb.video_name(v_id)
      if video
        video.url = url
        video.name = name
      else
        video = self.new(
          :video_id => v_id,
          :url => url,
          :name => name)
      end
    end
    video.views+=1
    video.save
    video
  end

  def set_cached_at_time
    self.cached_at = Time.now
  end

end
