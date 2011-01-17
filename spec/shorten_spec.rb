require 'spec_helper'

describe Googl::Shorten do

  before :each do
    fake_urls
  end

  context "when request new short url" do

    it { Googl.should respond_to(:shorten) }

    context "with invalid url" do

      it "should return error for required url" do
        lambda { Googl.shorten }.should raise_error(ArgumentError, "URL to shorten is required")
      end

      it "should return Unsupported content with type" do
        Request.headers.delete('Content-Type')
        lambda { Googl.shorten('http://www.uol.com') }.should raise_error(Exception, /Unsupported content with type: application\/x-www-form-urlencoded/)
      end
      
    end

    context "with valid url" do

      subject { Googl.shorten('http://www.zigotto.com') }

      describe "#short_url" do
        it "should return a short URL" do
          subject.short_url.should == 'http://goo.gl/ump4S'
        end
      end

      describe "#long_url" do
        it "should return a long url" do
          subject.long_url.should == 'http://www.zigotto.com/'
        end
      end

      describe "#qr_code" do
        it "should return a url for generate a qr code" do
          subject.qr_code.should == 'http://goo.gl/ump4S.qr'
        end
      end

    end

  end

end
