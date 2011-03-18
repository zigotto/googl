module Googl

  class Shorten < Base

    include Googl::Utils

    attr_accessor :short_url, :long_url

    # Creates a new short URL, see Googl.shorten
    #
    def initialize(long_url)
      modify_headers('Content-Type' => 'application/json')
      options = {"longUrl" => long_url}.to_json
      resp = post(API_URL, :body => options)
      if resp.code == 200
        self.short_url  = resp['id']
        self.long_url   = resp['longUrl']
      else
        raise exception(resp.parsed_response)
      end
    end

  end

end
