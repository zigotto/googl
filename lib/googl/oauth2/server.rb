module Googl
  module OAuth2

    class Server

      include Googl::Utils
      include Googl::OAuth2::Utils

      attr_accessor :client_id, :client_secret, :redirect_uri, :access_token, :refresh_token, :expires_in

      def initialize(client_id, client_secret, redirect_uri)
        self.client_id     = client_id
        self.client_secret = client_secret
        self.redirect_uri  = redirect_uri
      end

      def authorize_url
        make_authorize_url(redirect_uri)
      end

      def request_access_token(code)
        request_token(code, redirect_uri)
      end

    end

  end
end
