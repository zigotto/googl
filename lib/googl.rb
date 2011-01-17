require 'httparty'
require 'ostruct'

require 'googl/base'
require 'googl/request'
require 'googl/shorten'
require 'googl/expand'
require 'googl/client_login'
require 'googl/ruby_extensions'

module Googl

  def self.shorten(url)
    Googl::Shorten.new(url)
  end

  def self.expand(url, options={})
    options = {:shortUrl => url, :projection => nil}.merge!(options)
    Googl::Expand.new(options)
  end

  def self.client(email, passwd)
    Googl::ClientLogin.new(email, passwd)
  end

end
