module Googl

  class Shorten < Base

    include Googl::Utils

    attr_accessor :short_url, :long_url

    # Creates a new short URL, see Googl.shorten
    #
    def initialize(long_url, user_ip = nil, api_key = nil)
      modify_headers('Content-Type' => 'application/json')
      options = {"longUrl" => long_url}
      shorten_url = API_URL

      if (user_ip != nil && !user_ip.empty?)
        options["userIp"] = user_ip
      end
      if (api_key != nil && !api_key.empty?)
        shorten_url += "?key=#{api_key}"
      end

      options_json = options.to_json
      resp = post(shorten_url, :body => options_json)
      if resp.code == 200
        self.short_url  = resp['id']
        self.long_url   = resp['longUrl']
      else
        raise exception(resp.parsed_response)
      end
    end

  end

end
