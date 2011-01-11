require 'spec_helper'

describe Googl::Expand do

  before :each do
    fake_urls
  end
  
  context "when expand any goo.gl short URL" do

    subject { Googl::Expand.new('http://goo.gl/7lob') }

    describe "#long_url" do
      it "should return a long url" do
        subject.long_url.should == 'http://jlopes.zigotto.com.br/'
      end
    end

  end


end
