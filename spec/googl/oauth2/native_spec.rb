require 'spec_helper'

describe Googl::OAuth2::Native do

  before :each do
    fake_urls? true
  end

  subject do
    Googl::OAuth2::Native.new("185706845724.apps.googleusercontent.com", "DrBLCdCQ3gOybHrj7TPz/B0N")
  end

  describe "#initialize" do

    it "should assign client_id" do
      subject.client_id.should == "185706845724.apps.googleusercontent.com"
    end

    it "should assign client_secret" do
      subject.client_secret.should == "DrBLCdCQ3gOybHrj7TPz/B0N"
    end

  end

  describe "#authorize_url" do

    it { subject.should respond_to(:authorize_url) }

    it "should return url for authorize" do
      subject.authorize_url.should == "https://accounts.google.com/o/oauth2/auth?client_id=185706845724.apps.googleusercontent.com&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/urlshortener&response_type=code"
    end

    it "should include the client_id" do
      subject.authorize_url.should be_include("client_id=185706845724.apps.googleusercontent.com")
    end

    it "should include the redirect_uri" do
      subject.authorize_url.should be_include("redirect_uri=urn:ietf:wg:oauth:2.0:oob")
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

      let(:native) { subject.request_access_token("4/SuSud6RqPojUXsPpeh-wSVCwnmTQ") }

      it "should return a access_token" do
        native.access_token.should == "1/YCzoGAYT8XUuOifjNh_KqA"
      end

      it "should return a refresh_token" do
        native.refresh_token.should == "1/x_31GvgzdgHDMkRep5i8YxFlq76w3yjFu9Dp72Op-pI"
      end

      it "should return a expires_in" do
        native.expires_in.should == 3600
      end

    end

    context "with invalid code" do
      it "should raise error" do
        lambda {  subject.request_access_token("my_invalid_code")  }.should raise_error(/400 invalid_token/)
      end
      it "should raise Invalid Credentials on 401 response" do
        lambda {  subject.request_access_token("4/JvkEhCtr7tv1A60ENmubQT-cosRl")  }.should raise_error(/401 Invalid Credentials/)
      end
    end

  end

  describe "#expires_at" do

    before do
      @now = Time.now
      Time.stub!(:now).and_return(@now)
    end

    let(:native) { subject.request_access_token("4/SuSud6RqPojUXsPpeh-wSVCwnmTQ") }

    it "should be a time representation of #expires_in" do
      native.expires_at.should == (@now + 3600)
    end

  end

  describe "#expires?" do

    before :each do
      Time.stub!(:now).and_return(Time.parse("2011-04-23 15:30:00"))
      subject.request_access_token("4/SuSud6RqPojUXsPpeh-wSVCwnmTQ")
    end

    it "should be true if access token expires" do
      Time.stub!(:now).and_return(Time.parse("2011-04-23 18:30:00"))
      subject.expires?.should be_true
    end

    it "should be false if access token not expires" do
      subject.expires?.should be_false
    end

  end

  describe "#authorized?" do
    
    it "should return false if client is not authorized" do
      subject.authorized?.should be_false
    end

    let(:native) { subject.request_access_token("4/SuSud6RqPojUXsPpeh-wSVCwnmTQ") }

    it "should return true if client is authorized" do
      native.authorized?.should be_true
    end

  end

  context "when gets a user history of shortened" do

    it { subject.should respond_to(:history) }

    it "should not return when client not authorized" do
      subject.history.should be_nil
    end

    context "if authorized" do

      let(:native) { subject.request_access_token("4/SuSud6RqPojUXsPpeh-wSVCwnmTQ") }
      let(:history) { native.history }

      it { history.should respond_to(:total_items) }
      it { history.should respond_to(:items_per_page) }
      it { history.should respond_to(:items) }

    end

  end

end
