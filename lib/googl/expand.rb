module Googl

  class Expand < Base

    API_URL = "https://www.googleapis.com/urlshortener/v1/url"

    attr_accessor :long_url, :analytics, :status, :short_url, :created

    # Expands a short URL or gets creation time and analytics. See Googl.expand
    #
    def initialize(options={})

      options.delete_if {|key, value| value.nil?}

      resp = Googl::Request.get(API_URL, :query => options)
      if resp.code == 200
        @created    = resp['created'] if resp.has_key?('created')
        @long_url   = resp['longUrl']
        @analytics  = resp['analytics'].to_openstruct if resp.has_key?('analytics')
        @status     = resp['status']
        @short_url  = resp['id']
      else
        raise Exception.new("#{resp.code} #{resp.message}")
      end
    end

  end

end
