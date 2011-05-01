module Googl
  module OAuth2

    module Utils

      attr_accessor :client_id, :client_secret, :access_token, :refresh_token, :expires_in, :expires_at
      attr_accessor :items

      def expires?
        expires_at < Time.now
      end

      def authorized?
        !access_token.nil? && !refresh_token.nil? && !expires_in.nil? && !expires_at.nil?
      end

      # Gets a user's history of shortened URLs.
      #
      def history(options={})
        return unless authorized?
        resp = options.blank? ? get(Googl::Utils::API_HISTORY_URL) : get(Googl::Utils::API_HISTORY_URL, :query => options)
        case resp.code
        when 200
          self.items = resp.parsed_response.to_openstruct
        else
          raise exception("#{resp.code} #{resp.parsed_response}")
        end
      end

      private

      def request_token(code, request_uri="urn:ietf:wg:oauth:2.0:oob")
        params = "code=#{code}&client_id=#{client_id}&client_secret=#{client_secret}&redirect_uri=#{request_uri}&grant_type=authorization_code"
        modify_headers('Content-Type' => 'application/x-www-form-urlencoded')
        resp = post("https://accounts.google.com/o/oauth2/token", :body => params)
        case resp.code
        when 200
          modify_headers("Authorization" => "OAuth #{resp["access_token"]}")
          self.access_token  = resp["access_token"]
          self.refresh_token = resp["refresh_token"]
          self.expires_in    = resp["expires_in"]
          self.expires_at    = Time.now + expires_in if expires_in
          self
        when 401
          raise exception("#{resp.code} #{resp.parsed_response["error"]["message"]}")
        else
          raise exception("#{resp.code} #{resp.parsed_response["error"]}")
        end
      end

      def make_authorize_url(redirect_uri)
        "https://accounts.google.com/o/oauth2/auth?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{Googl::Utils::SCOPE_URL}&response_type=code"
      end

    end

  end
end
