require 'spec_helper'

describe Googl::OAuth2::Server do

  before :each do
    fake_urls? true
  end

  subject do
    Googl::OAuth2::Server.new("438834493660.apps.googleusercontent.com", "8i4iJJkFTukWhNpxTU1b2Zhi", "http://gooogl.heroku.com/back")
  end

  describe "#initialize" do
    
    it "should assign client_id" do
      subject.client_id.should == "438834493660.apps.googleusercontent.com"
    end
      
    it "should assign client_secret" do
      subject.client_secret.should == "8i4iJJkFTukWhNpxTU1b2Zhi"
    end
      
    it "should assign redirect_uri" do
      subject.redirect_uri.should == "http://gooogl.heroku.com/back"
    end

  end

  describe "#authorize_url" do

    it { subject.should respond_to(:authorize_url) }

    it "should return url for authorize" do
      subject.authorize_url.should == "https://accounts.google.com/o/oauth2/auth?client_id=438834493660.apps.googleusercontent.com&redirect_uri=http://gooogl.heroku.com/back&scope=https://www.googleapis.com/auth/urlshortener&response_type=code"
    end

    it "should include the client_id" do
      subject.authorize_url.should be_include("client_id=438834493660.apps.googleusercontent.com")
    end

    it "should include the redirect_uri" do
      subject.authorize_url.should be_include("redirect_uri=http://gooogl.heroku.com/back")
    end

    it "should include the scope" do
      subject.authorize_url.should be_include("scope=https://www.googleapis.com/auth/urlshortener")
    end

    it "should include the response_type" do
      subject.authorize_url.should be_include("response_type=code")
    end

  end

  describe "#request_access_token" do
    
    it { subject.should respond_to(:request_access_token) }

    context "with valid code" do

      let(:server) { subject.request_access_token("4/z43CZpNmqd0IO3dR1Y_ouase13CH") }

      it "should return a access_token" do
        server.access_token.should == "1/9eNgoHDXi-1u1fDzZ2wLLGATiaQZnWPB51nTvo8n9Sw"
      end

      it "should return a refresh_token" do
        server.refresh_token.should == "1/gvmLC5XlU0qRPIBR3mt7OBBfEoTKB6i2T-Gu4dBDupw"
      end

      it "should return a expires_in" do
        server.expires_in.should == 3600
      end

    end

    context "with invalid code" do
      it "should raise error" do
        lambda {  subject.request_access_token("my_invalid_code")  }.should raise_error(Exception, /400 invalid_token/)
      end
    end

  end

  describe "#expires_at" do

    before do
      @now = Time.now
      Time.stub!(:now).and_return(@now)
    end

    let(:server) { subject.request_access_token("4/z43CZpNmqd0IO3dR1Y_ouase13CH") }

    it "should be a time representation of #expires_in" do
      server.expires_at.should == (@now + 3600)
    end

  end

  describe "#expires?" do
    it "should be false if there is no expires_at" do
      pending
    end
    it "should be true if there is an expires_at" do
      pending
    end
  end

end
