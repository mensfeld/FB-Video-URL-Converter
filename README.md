# Facebook Video URL Converter

## Install

    gem install fb_video_url_converter

and in your Gemfile:
    
    gem 'fb_video_url_converter'

## About

Facebook Video URL Converter is intended as an easy alternative to
changing video hosting from Facebook to a different one.

When you upload a movie to a Facebook profile, it is available through a URL.
However, if You want to insert your movie into external player (like JW Player),
you will have a problem. Facebook recently found out, that lots of websites
use them as a free HD video hosting. Each 24h they switch authorization
parameters, so you cannot embed links directly.

You need to refresh URLs with Facebook. That is why I've developed this small
piece of code. It gets MP4 file URL and cache it for 30 minutes. When cache
expires it checks URL header response and if it fails it refresh cache.

Works for approximately 99% of time.

Works with Ruby 1.8.7, 1.8.7 EE, 1.9.2

## Requirements

Facebook Video URL Converter uses ActiveRecord to store cached data.
You need to create a migration containing:

    class CreateFacebookVideos < ActiveRecord::Migration
      def self.up
        create_table :facebook_videos do |t|
          t.column :video_id, :string
          t.column :name, :string
          t.column :url, :string, :default => nil
          t.column :views, :integer, :default => 1
          t.column :cached_at, :datetime
        end

        add_index :facebook_videos, :video_id
        add_index :facebook_videos, :url
      end

      def self.down
        drop_table :facebook_videos
      end
    end

or without migrations:

    unless FacebookVideo.table_exists?
      ActiveRecord::Base.connection.create_table(:facebook_videos) do |t|
        t.column :video_id, :string
        t.column :name, :string
        t.column :url, :string, :default => nil
        t.column :views, :integer, :default => 1
        t.column :cached_at, :datetime
      end
    end

## Example

    url = 'http://www.facebook.com/home.php?#!/video/video.php?v=SOME_ID'
    p FacebookVideo.get(url).url

    => 'http://video.ak.fbcdn.net/cfs-ak-ash4/214...long_long_url'

    p FacebookVideo.get(url).name

    => 'video_name'

you can use also `working?` to determine if object you have got is a valid
Facebook movie object. If not - use `object.error` to determine what type of
error has occurred.

## Setup

When you create table required by Facebook Video URL Converter, you need to do
one more thing - you need to setup your Facebook account. To do so, create
initializer containing:

    FacebookBot.email = 'insert_here_mail@facebook.com'
    FacebookBot.password = 'pass'
    # Cache storage - in seconds
    FacebookVideo.cache = 60*10

Insert your own account data and you are ready to go :)

## Tests

If you want to run rspec tests - you will need to modify:

    FacebookBot.email = 'test@test.pl'
    FacebookBot.password = 'pass'
    # Cache storage - in seconds
    FacebookVideo.cache = 60*10

and set them according to your own profile.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Maciej Mensfeld. See LICENSE for details.
