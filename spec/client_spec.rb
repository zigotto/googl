require 'spec_helper'

describe Googl::ClientLogin do

  before :each do
    fake_urls
  end

  context "request a new client login" do

    it { Googl.should respond_to(:client) }

    context "when valid" do

      subject { Googl.client('my_user@gmail.com', 'my_valid_password') }

      describe "#code" do
        it "should return 200" do
          subject.code.should == 200
        end
      end

    end

    context "when invalid" do

      subject { Googl.client('my_invalid_gmail', 'my_invalid_passwod') }

      describe "#code" do
        it "should return 403" do
          subject.code.should == 403
        end
      end
      
    end

  end

  context "request new shor url" do

    before :each do
      @client = Googl.client('my_user@gmail.com', 'my_valid_password') 
    end

    it { @client.should respond_to(:shorten) }

    subject { @client.shorten('http://www.zigotto.net') }

    describe "#short_url" do
      it "should return a short URL" do
        subject.short_url.start_with?("http://goo.gl/").should be_true
      end
    end
    
  end

end
