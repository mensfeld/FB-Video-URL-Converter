$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'singleton'

class <<Singleton
  def included_with_reset(klass)
    included_without_reset(klass)
    class <<klass
      def reset_instance
        Singleton.send :__init__, self
        self
      end
    end
  end
  alias_method :included_without_reset, :included
  alias_method :included, :included_with_reset
end

require 'rubygems'
require 'sqlite3'
require 'fb_video_url_converter'
require 'active_record'
require 'fileutils'

FacebookBot.email = 'mail@mail.pl'
FacebookBot.password = 'pass'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => ":memory:"
)


unless FacebookVideo.table_exists?
  ActiveRecord::Base.connection.create_table(:facebook_videos) do |t|
    t.column :video_id, :string
    t.column :name, :string
    t.column :url, :string, :default => nil
    t.column :views, :integer, :default => 1
    t.column :cached_at, :datetime
  end
end
