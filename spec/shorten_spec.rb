require 'spec_helper'

describe Googl::Shorten do

  before :each do
    fake_urls
  end

  context "when request new short url" do

    it { Googl.should respond_to(:shorten) }

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
