require 'httparty'
require 'ostruct'

require 'googl/base'
require 'googl/request'
require 'googl/shorten'
require 'googl/expand'
require 'googl/client_login'
require 'googl/ruby_extensions'

module Googl

  def self.shorten(url=nil)
    raise ArgumentError.new("URL to shorten is required") if url.blank?
    Googl::Shorten.new(url)
  end

  def self.expand(url=nil, options={})
    raise ArgumentError.new("URL to expand is required") if url.blank?
    options = {:shortUrl => url, :projection => nil}.merge!(options)
    Googl::Expand.new(options)
  end

  def self.client(email, passwd)
    Googl::ClientLogin.new(email, passwd)
  end

end
