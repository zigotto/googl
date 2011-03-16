module Googl

  class ClientLogin < Base

    API_URL         = "https://www.google.com/accounts/ClientLogin"
    API_HISTORY_URL = "https://www.googleapis.com/urlshortener/v1/url/history"

    attr_accessor :code, :items

    # The Google URL Shortener API ClientLogin authentication. See Googl.client
    #
    def initialize(email, passwd)
      modify_headers('Content-Type' => 'application/x-www-form-urlencoded')
      resp = Googl::Request.post(API_URL, :body => params.merge!('Email' => email, 'Passwd' => passwd))
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

    # Gets a user's history of shortened URLs. (Authenticated)
    #
    #   client = Googl.client('user@gmail.com', 'my_valid_password')
    #
    #   history = client.history
    #   history.total_items
    #   => 19
    #
    # A list of URL.
    #
    #   history.items
    #
    # Analytics details for all items
    #
    #   history = client.history(:projection => :analytics_clicks)
    #
    def history(options={})
      resp = options.blank? ? Googl::Request.get(API_HISTORY_URL) : Googl::Request.get(API_HISTORY_URL, :query => options)
      if resp.code == 200
        @items = resp.parsed_response.to_openstruct
      else
        raise Exception.new("#{resp.code} #{resp.parsed_response}")
      end
    end

    private

    def params
      {'accountType' => 'HOSTED_OR_GOOGLE', 'service' => 'urlshortener', 'source' => 'gem-googl-ruby'}
    end

  end

end
