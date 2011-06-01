module FbVideoUrlConverter
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add_my_migration
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      source = "create_facebook_videos_migration.rb"
      target = "db/migrate/#{timestamp}_create_facebook_videos.rb"
      copy_file source, target
    end

    def add_initializer
      source = "facebook_video_converter_init.rb"
      target = "config/initializers/facebook_video_converter.rb"
      copy_file source, target
    end

  end
end


