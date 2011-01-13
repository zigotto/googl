require 'httparty'

require 'googl/request'
require 'googl/shorten'
require 'googl/expand'

module Googl

  def self.shorten(url)
    Googl::Shorten.new(url)
  end

  def self.expand(url)
    Googl::Expand.new(url)
  end

end
