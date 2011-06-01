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
