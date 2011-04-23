module Googl
  module OAuth2

    class Native

      include Googl::Utils
      include Googl::OAuth2::Utils

      attr_accessor :client_id, :client_secret, :access_token, :refresh_token, :expires_in, :expires_at

      def initialize(client_id, client_secret)
        self.client_id     = client_id
        self.client_secret = client_secret
      end

      def authorize_url
        make_authorize_url("urn:ietf:wg:oauth:2.0:oob")
      end

      def request_access_token(code)
        request_token(code)
      end

    end

  end
end
