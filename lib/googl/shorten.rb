module Googl

  class Shorten < Base

    include Googl::Utils

    attr_accessor :short_url, :long_url

    # Creates a new short URL, see Googl.shorten
    #
    def initialize(long_url, args = {})
      args = {:unique => false}.merge(args) 
      modify_headers('Content-Type' => 'application/json')
 
      # if long_url exists in history
      # return the related short_url
      if args[:unique] && !Googl.client.nil?
        to_check = URI(long_url)
        to_check.scheme ||= 'http'
        to_check.path += '/' if(to_check.path[-1] != '/')
        Googl.client.history.items.each do |item|
          uri_from_history = URI(item.long_url)

          if(to_check.scheme == uri_from_history.scheme && 
             to_check.host == uri_from_history.host && 
             to_check.path == uri_from_history.path && 
             to_check.query == uri_from_history.query)
            self.short_url  = item.label
            self.long_url   = item.long_url
            return self
          end

        end
      end

      options = {"longUrl" => long_url}.to_json
      resp = post(API_URL, :body => options)
      if resp.code == 200
        self.short_url  = resp['id']
        self.long_url   = resp['longUrl']
      else
        raise exception(resp.parsed_response)
      end
    end

  end

end
