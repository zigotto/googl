require 'spec_helper'

describe Googl::Expand do

  before :each do
    fake_urls? true
  end

  context "when expand any goo.gl short URL" do

    it { Googl.should respond_to(:expand) }

    context "wirh invalid url" do

      it "should return error 404" do
        lambda { Googl.expand('http://goo.gl/blajjddkksijj') }.should raise_error(Exception, /404 Not Found/)
      end

      it "should return error for required url" do
        lambda { Googl.expand }.should raise_error(ArgumentError, /URL to expand is required/)
      end

      it "should return status REMOVED" do
        Googl.expand('http://goo.gl/R7f68').status.should == 'REMOVED'
      end

    end

    context "with valid url" do

      subject { Googl.expand('http://goo.gl/7lob') }

      describe "#long_url" do
        it "should return a long url" do
          subject.long_url.should == 'http://jlopes.zigotto.com.br/'
        end
      end

      describe "#status" do
        it "should return a status of url" do
          subject.status.should == 'OK'
        end
      end

      describe "#qr_code" do
        it "should return a url for generate a qr code" do
          subject.qr_code.should == 'http://goo.gl/7lob.qr'
        end
      end

      describe "#info" do
        it "should return url for analytics" do
          subject.info.should == 'http://goo.gl/7lob.info'
        end
      end

      context "with projection" do

        context "full" do

          subject { Googl.expand('http://goo.gl/DWDfi', :projection => :full) }

          describe "#created" do
            let(:element) { subject.created.to_s }

            it "should be the time url was shortened" do
              element.should be == '2011-01-13 01:48:10 -0200'
            end

          end

          describe "#all_time" do
            let(:element) { subject.analytics.all_time }

            it_should_behave_like 'a clicks'
            it_should_behave_like 'a period'

            it "should rename id to label" do
              element.countries.first.label.should == "BR"
            end
          end

          describe "#month" do
            let(:element) { subject.analytics.month }

            it_should_behave_like 'a clicks'
            it_should_behave_like 'a period'
          end

          describe "#week" do
            let(:element) { subject.analytics.week }

            it_should_behave_like 'a clicks'
            it_should_behave_like 'a period'
          end

          describe "#day" do
            let(:element) { subject.analytics.day }

            it_should_behave_like 'a clicks'
            it_should_behave_like 'a period'
          end

          describe "#two_hours" do
            let(:element) { subject.analytics.two_hours }

            it_should_behave_like 'a clicks'
          end

        end

        context "analytics_clicks" do

          subject { Googl.expand('http://goo.gl/DWDfi', :projection => :analytics_clicks) }

          describe "#all_time" do
            let(:element) { subject.analytics.all_time }

            it_should_behave_like 'a clicks'
          end

          describe "#month" do
            let(:element) { subject.analytics.month }

            it_should_behave_like 'a clicks'
          end

          describe "#week" do
            let(:element) { subject.analytics.week }

            it_should_behave_like 'a clicks'
          end

          describe "#day" do
            let(:element) { subject.analytics.day }

            it_should_behave_like 'a clicks'
          end

          describe "#two_hours" do
            let(:element) { subject.analytics.two_hours }

            it_should_behave_like 'a clicks'
          end

        end

        context "analytics_top_strings" do

          subject { Googl.expand('http://goo.gl/DWDfi', :projection => :analytics_top_strings) }

          describe "#all_time" do
            let(:element) { subject.analytics.all_time }

            it_should_behave_like 'a period'
          end

          describe "#month" do
            let(:element) { subject.analytics.month }

            it_should_behave_like 'a period'
          end

          describe "#week" do
            let(:element) { subject.analytics.week }

            it_should_behave_like 'a period'
          end

          describe "#day" do
            let(:element) { subject.analytics.day }

            it_should_behave_like 'a period'
          end

        end

      end

    end

  end

end
