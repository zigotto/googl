require 'spec_helper'

describe Googl::Expand do
  
  context "when expand any goo.gl short URL" do

    subject { Googl::Expand.new('http://goo.gl/ump4S') }

    describe "#long_url" do
      it "should return a long url" do
        subject.long_url.should == 'http://www.zigotto.com/'
      end
    end

  end


end
