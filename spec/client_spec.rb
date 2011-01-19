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

      it "should return BadAuthentication" do
        lambda { Googl.client('my_invalid_gmail', 'my_invalid_passwod') }.should raise_error(Exception, /403 Error=BadAuthentication/)
      end
      
    end

  end

  context "request new short url" do

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

  context "when gets a user history of shortened" do

    let(:client) { Googl.client('my_user@gmail.com', 'my_valid_password')  }

    it { client.should respond_to(:history) }

    subject { client.history }

    it { subject.should respond_to(:total_items) }
    it { subject.should respond_to(:items_per_page) }

    describe "#items" do

      it { subject.should respond_to(:items) }

      let(:item) { subject.items.first }

      it { item.kind.should == 'urlshortener#url'}
      it { item.label.should == 'http://goo.gl/Ue8sQ' }
      it { item.long_url.should == 'http://facebook.com/' }
      it { item.status.should == 'OK' }
      it { item.created.should be_instance_of(Time)}

    end

    context "with projection" do

      context "analytics_clicks" do

        subject { client.history(:projection => :analytics_clicks) }

        describe "#analytics" do

          let(:item) { subject.items.first }

          it { item.should respond_to(:analytics) }

          describe "#all_time" do
            let(:all_time) { item.analytics.all_time }
            it { all_time.should respond_to(:short_url_clicks) }
          end

          describe "#month" do
            let(:month) { subject.items.first.analytics.month }
            it { month.should respond_to(:short_url_clicks) }
          end

          describe "#week" do
            let(:week) { subject.items.first.analytics.week }
            it { week.should respond_to(:short_url_clicks) }
          end

          describe "#day" do
            let(:day) { subject.items.first.analytics.day }
            it { day.should respond_to(:short_url_clicks) }
          end

          describe "#two_hours" do
            let(:two_hours) { subject.items.first.analytics.two_hours }
            it { two_hours.should respond_to(:short_url_clicks) }
          end
        end

      end
      
    end

  end

end
