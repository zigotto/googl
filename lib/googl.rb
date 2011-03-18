require 'httparty'
require 'ostruct'
require 'json'

require 'googl/utils'
require 'googl/base'
require 'googl/request'
require 'googl/shorten'
require 'googl/expand'
require 'googl/client_login'
require 'googl/ruby_extensions'

require 'googl/oauth2/native'
require 'googl/oauth2/server'

module Googl

  # Creates a new short URL
  #
  #   url = Googl.shorten('http://www.zigotto.com')
  #   url.short_url
  #   => "http://goo.gl/ump4S"
  #
  def self.shorten(url=nil)
    raise ArgumentError.new("URL to shorten is required") if url.blank?
    Googl::Shorten.new(url)
  end

  # Expands a short URL or gets creation time and analytics
  #
  #   url = Googl.expand('http://goo.gl/ump4S')
  #   url.long_url
  #   => "http://www.zigotto.com/"
  #
  # For analytics and additional information to return (using the :projection parameter)
  #
  #   * :full => returns the creation timestamp and all available analytics
  #   * :analytics_clicks => returns only click counts
  #   * :analytics_top_strings => returns only top string counts (e.g. referrers, countries, etc)
  #
  #   url = Googl.expand('http://goo.gl/DWDfi', :projection => :full)
  #
  #   url.analytics.all_time.browsers.first.label
  #   => "Chrome"
  #   url.analytics.all_time.browsers.first.count
  #   => "11"
  #
  # A summary of the click analytics for the short and long URL
  #
  #   url.analytics
  #
  # Analytics details for a particular window of time; counts in this object are of clicks that occurred within the most recent window of this length.
  #
  #   url.analytics.all_time
  #   url.analytics.month
  #   url.analytics.week
  #   url.analytics.day
  #   url.analytics.two_hours
  #
  # Number of clicks on this short URL. Replace (*) for all_time, month, week, day or two_hours
  #
  #   url.analytics.*.short_url_clicks
  #
  # Number of clicks on all goo.gl short URLs pointing to this long URL.
  #
  #   url.analytics.*.long_url_clicks
  #
  # Top referring hosts, e.g. "www.google.com"; sorted by (descending) click counts. Only present if this data is available.
  #
  #   url.analytics.*.referrers
  #
  # Top countries (expressed as country codes), e.g. "US" or "DE"; sorted by (descending) click counts.
  #
  #   url.analytics.*.countries
  #
  # Top browsers, e.g. "Chrome"; sorted by (descending) click counts.
  #
  #   url.analytics.*.browsers
  #
  # Top platforms or OSes, e.g. "Windows"; sorted by (descending) click counts.
  #
  #   url.analytics.*.platforms
  #
  # For mor details, see http://code.google.com/intl/pt-BR/apis/urlshortener/v1/reference.html#resource_url
  #
  def self.expand(url=nil, options={})
    raise ArgumentError.new("URL to expand is required") if url.blank?
    options = {:shortUrl => url, :projection => nil}.merge!(options)
    Googl::Expand.new(options)
  end

  # The Google URL Shortener API ClientLogin authentication.
  #
  #   client = Googl.client('user@gmail.com', 'my_valid_password')
  #
  #   url = client.shorten('https://github.com/zigotto/googl')
  #   url.short_url
  #   => http://goo.gl/DWDfi
  #
  # Go to http://goo.gl to see URL statistics.
  #
  def self.client(email, passwd)
    Googl::ClientLogin.new(email, passwd)
  end

end
