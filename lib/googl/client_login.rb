module Googl

  class ClientLogin < Base

    API_URL = "https://www.google.com/accounts/ClientLogin"

    PARAMS = {'accountType' => 'HOSTED_OR_GOOGLE', 'service' => 'urlshortener', 'source' => 'gem-googl-ruby'}

    attr_accessor :code

    # The Google URL Shortener API ClientLogin authentication. See Googl.client
    #
    def initialize(email, passwd)
      modify_headers('Content-Type' => 'application/x-www-form-urlencoded')
      resp = Request.post(API_URL, :body => PARAMS.merge!('Email' => email, 'Passwd' => passwd))
      @code = resp.code
      if resp.code == 200
        token = resp.split('=').last.gsub(/\n/, '')
        modify_headers("Authorization" => "GoogleLogin auth=#{token}")
      else
        raise Exception.new("#{resp.code} #{resp.parsed_response}")
      end
    end

    # Creates a new short URL and thus will gather unique click statistics. It shows up on the user’s dashboard at http://goo.gl.
    #
    # See Googl.client
    #
    def shorten(url)
      Googl::Shorten.new(url)
    end

  end

end
