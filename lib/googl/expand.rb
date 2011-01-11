module Googl

  class Expand

    attr_accessor :long_url

    def initialize(short_url)
      resp = Request.get("/urlshortener/v1/url?shortUrl=#{short_url}")
      if resp.code == 200
        self.long_url   = resp['longUrl']
      else
        resp.response
      end
    end

  end

end
