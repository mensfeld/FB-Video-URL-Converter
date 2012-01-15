require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))


def remove_cookie
  c_p = File.join(ROOT, '..', 'lib', "cookie_#{FacebookBot.email}.yml")
  #FileUtils.rm( c_p ) if File.file?( c_p )
end

describe FacebookBot do
  subject { FacebookBot }
  # Remove cookie files
  after(:all){ remove_cookie }

  context "when we are not logged in" do
    context "and login is correct" do
      it "should log us in" do
        subject.new
      end
    end

    context "and login or password is incorrect" do
      it "should throw failed exception" do
        l = subject.email
        subject.email = 'incorrect@incorrect.pl'
        lambda { subject.new }.should raise_error(subject::LoginFailed, 'Incorrect login/password or cookie corrupted')
        remove_cookie
        subject.email = l
      end
    end


    context "and we don't specify cookie path" do
      it "should throw failed exception" do
        l = subject.cookie_path
        subject.cookie_path = nil
        lambda { subject.new }.should raise_error(subject::CookiePathNotInitialized, 'Specify cookie_path')
        subject.cookie_path = l
      end
    end
  end

  context "when we are logged in" do
    it "should obtain valid url of a valid movie" do
      fb = subject.new
      fb.video_url('111449252268656').should_not eql 'video_id_error'
    end

    it "should obtain valid name of a valid movie" do
      fb = subject.new
      fb.video_name('111449252268656').should eql 'Naruto Shippuuden #203 Part2'
    end

    it "should obtain valid error msg of a invalid movie" do
      fb = subject.new
      fb.video_url('1aaaaa').should eql 'video_id_error'
    end

  end

end
