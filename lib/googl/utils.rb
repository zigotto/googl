module Googl

  module Utils # :nodoc:

    API_URL              = 'https://www.googleapis.com/urlshortener/v1/url'
    API_HISTORY_URL      = "https://www.googleapis.com/urlshortener/v1/url/history"
    API_CLIENT_LOGIN_URL = "https://www.google.com/accounts/ClientLogin"
    SCOPE_URL            = "https://www.googleapis.com/auth/urlshortener"

    private

    def modify_headers(item)
      Googl::Request.headers.merge!(item)
    end

    def post(url, params={})
      Googl::Request.post(url, params)
    end

    def get(url, params={})
      Googl::Request.get(url, params)
    end

    def exception(msg)
      Exception.new(msg)
    end

  end

end
