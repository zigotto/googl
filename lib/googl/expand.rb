module Googl

  class Expand

    API_URL = "https://www.googleapis.com/urlshortener/v1/url"

    attr_accessor :long_url, :analytics

    def initialize(options={})

      options.delete_if {|key, value| value.nil?}

      resp = Request.get(API_URL, :query => options)
      if resp.code == 200
        @long_url   = resp['longUrl']
        @analytics  = resp['analytics'].to_openstruct if resp.has_key?('analytics')
      else
        resp.response
      end
    end

  end

end
