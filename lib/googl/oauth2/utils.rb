module Googl
  module OAuth2
    module Utils

      def request_token(code, request_uri="urn:ietf:wg:oauth:2.0:oob")
        params = "code=#{code}&client_id=#{client_id}&client_secret=#{client_secret}&redirect_uri=#{request_uri}&grant_type=authorization_code"
        modify_headers('Content-Type' => 'application/x-www-form-urlencoded')
        resp = post("https://accounts.google.com/o/oauth2/token", :body => params)
        if resp.code == 200
          modify_headers("Authorization" => "OAuth #{resp["access_token"]}")
          self.access_token  = resp["access_token"]
          self.refresh_token = resp["refresh_token"]
          self.expires_in    = resp["expires_in"]
          self
        else
          raise exception("#{resp.code} #{resp.parsed_response["error"]}")
        end
      end

      def expires_at
        Time.now + expires_in if expires_in
      end

      def make_authorize_url(redirect_uri)
        "https://accounts.google.com/o/oauth2/auth?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{Googl::Utils::SCOPE_URL}&response_type=code"
      end

    end
  end
end
