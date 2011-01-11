require 'spec_helper'

describe Googl::Expand do

  before :each do
    fake_urls
  end
  
  context "when expand any goo.gl short URL" do

    it { Googl.should respond_to(:expand) }

    subject { Googl.expand('http://goo.gl/7lob') }

    describe "#long_url" do
      it "should return a long url" do
        subject.long_url.should == 'http://jlopes.zigotto.com.br/'
      end
    end

  end


end
