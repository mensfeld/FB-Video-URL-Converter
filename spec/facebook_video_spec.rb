require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))


def remove_cookie
  c_p = File.join(ROOT, '..', 'lib', "cookie_#{FacebookBot.email}.yml")
  FileUtils.rm( c_p ) if File.file?( c_p )
end

describe FacebookVideo do
  subject { FacebookVideo }
  after(:all){ remove_cookie }

  context "when we obtain valid video for the first time" do
    it "should fetch it and return url" do
      FacebookVideo.get('111449252268656').name.should_not eql :video_id_error
      url = 'http://www.facebook.com/video/video.php?v=119040278176220&comments'
      FacebookVideo.get(url).name.should_not eql :video_id_error
    end

    it "should fetch it and return name" do
      FacebookVideo.get('111449252268656').name.should eql 'Naruto Shippuuden #203 Part2 [HD]'
      url = 'http://www.facebook.com/video/video.php?v=111449252268656&comments'
      FacebookVideo.get(url).name.should eql 'Naruto Shippuuden #203 Part2 [HD]'
    end
  end

  context "when we obtain video for n times" do
    it "should increase views counter" do
      FacebookVideo.get('111449252268656')
      v = FacebookVideo.find_by_video_id('111449252268656').views
      10.times do
        FacebookVideo.get('111449252268656')
      end
      FacebookVideo.find_by_video_id('111449252268656').views.should == v+10
    end
  end

  context "when video is too old" do
    it "should rerequest it and refresh cache time" do
      t = Time.now
      FacebookVideo.get('111449252268656')
      v = FacebookVideo.find_by_video_id('111449252268656')
      v.cached_at = Time.at(946702800)
      v.save!
      FacebookVideo.get('111449252268656')
      v.reload
      v.cached_at.should > t
    end
  end

  context "when we obtain invalid video" do
    it "should return warning" do
      FacebookVideo.get('').url.should eql :video_id_error
      FacebookVideo.get('').name.should eql :video_id_error
    end
  end

  context "when we cannot login to Facebook to obtain video" do
    it "should return incorrect video ID info" do
      l = FacebookBot.email
      FacebookBot.email = 'aaa@aaa.pl'
      FacebookVideo.get('120641554682759').url.should eql :fb_account_error
      remove_cookie
      FacebookBot.email = l
    end
  end

end
