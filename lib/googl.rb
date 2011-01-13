require 'httparty'

require 'googl/base'
require 'googl/request'
require 'googl/shorten'
require 'googl/expand'
require 'googl/client_login'

module Googl

  def self.shorten(url)
    Googl::Shorten.new(url)
  end

  def self.expand(url)
    Googl::Expand.new(url)
  end

  def self.client(email, passwd)
    Googl::ClientLogin.new(email, passwd)
  end

end
