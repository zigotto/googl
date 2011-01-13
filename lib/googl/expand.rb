module Googl

  class Expand

    API_URL = "https://www.googleapis.com/urlshortener/v1/url?shortUrl="

    attr_accessor :long_url

    def initialize(short_url)
      resp = Request.get(API_URL + short_url)
      if resp.code == 200
        @long_url   = resp['longUrl']
      else
        resp.response
      end
    end

  end

end
