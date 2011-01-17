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

    context "with projection" do

      context "full" do
        
        subject { Googl.expand('http://goo.gl/DWDfi', :projection => :full) }

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
