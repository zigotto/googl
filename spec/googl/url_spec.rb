require 'spec_helper'
describe Googl::Url do
  context "when creating an url" do
    it "should return error when empty" do
      lambda {Googl::Url.new("  ")}.should raise_error(ArgumentError, "URL is required")
    end
    it "should return error when not provided" do
      lambda {Googl::Url.new}.should raise_error(ArgumentError)
    end
  end
end
