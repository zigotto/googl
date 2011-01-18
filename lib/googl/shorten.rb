module Googl

  class Shorten < Base

    API_URL = 'https://www.googleapis.com/urlshortener/v1/url'

    attr_accessor :short_url, :long_url

    # Creates a new short URL, see Googl.shorten
    #
    def initialize(long_url)
      modify_headers('Content-Type' => 'application/json')
      options = {"longUrl" => long_url}.inspect
      resp = Request.post(API_URL, :body => options)
      if resp.code == 200
        @short_url  = resp['id']
        @long_url   = resp['longUrl']
      else
        raise Exception.new(resp.parsed_response)
      end
    end

    # URL for QR Code
    #
    #   url = Googl.shorten('http://goo.gl/ump4S')
    #   ur.qr_code
    #   => http://goo.gl/ump4S.qr
    #
    # Usage:
    #
    #   <img src="http://goo.gl/ump4S.qr" />
    #
    def qr_code
      "#{short_url}.qr" if !short_url.blank?
    end

  end

end
