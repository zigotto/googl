module Googl

  class ClientLogin

    include Googl::Utils

    attr_accessor :code, :items

    # The Google URL Shortener API ClientLogin authentication. See Googl.client
    #
    def initialize(email, passwd)
      modify_headers('Content-Type' => 'application/x-www-form-urlencoded')
      resp = post(API_CLIENT_LOGIN_URL, :body => params.merge!('Email' => email, 'Passwd' => passwd))
      self.code = resp.code
      if resp.code == 200
        token = resp.split('=').last.gsub(/\n/, '')
        modify_headers("Authorization" => "GoogleLogin auth=#{token}")
      else
        raise exception("#{resp.code} #{resp.parsed_response}")
      end
    end

    # Creates a new short URL and thus will gather unique click statistics. It shows up on the user’s dashboard at http://goo.gl.
    #
    # See Googl.client
    #
    def shorten(url, options = {})
      Googl.shorten(url, options)
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
      resp = (options.nil? || options.empty?) ? get(Googl::Utils::API_HISTORY_URL) : get(Googl::Utils::API_HISTORY_URL, :query => options)
      case resp.code
      when 200
        self.items = resp.parsed_response.to_openstruct
      else
        raise exception("#{resp.code} #{resp.parsed_response}")
      end
    end

    private

    def params
      {'accountType' => 'HOSTED_OR_GOOGLE', 'service' => 'urlshortener', 'source' => 'gem-googl-ruby'}
    end

  end

end
