module Googl
  module OAuth2

    class Native

      attr_accessor :client_id, :client_secret, :access_token, :refresh_token

      SCOPE = "https://www.googleapis.com/auth/urlshortener"

      def initialize(options={})
        options = {:client_id => "", :client_secret => ""}.merge(options)
        self.client_id = options[:client_id]
        self.client_secret = options[:client_secret]
      end

      def authorize_url
        "https://accounts.google.com/o/oauth2/auth?client_id=#{client_id}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=#{SCOPE}&response_type=code"
      end

      def request_access_token(code)
        params = "code=#{code}&client_id=#{client_id}&client_secret=#{client_secret}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code"
        Googl::Request.headers.merge!('Content-Type' => 'application/x-www-form-urlencoded')
        resp = Googl::Request.post("https://accounts.google.com/o/oauth2/token", :body => params)
        if resp.code == 200
          Googl::Request.headers.merge!("Authorization" => "OAuth #{resp["access_token"]}")
          self.access_token  = resp["access_token"]
          self.refresh_token = resp["refresh_token"]
          self
        else
          raise Exception.new("#{resp.code} #{resp.parsed_response["error"]}")
        end
      end

    end

  end
end
