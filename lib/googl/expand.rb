module Googl

  class Expand < Base

    include Googl::Utils

    attr_accessor :long_url, :analytics, :status, :short_url, :created

    # Expands a short URL or gets creation time and analytics. See Googl.expand
    #
    def initialize(options={})

      options.delete_if {|key, value| value.nil?}

      resp = get(API_URL, :query => options)
      if resp.code == 200
        created    = resp['created'] if resp.has_key?('created')
        self.long_url   = resp['longUrl']
        self.analytics  = resp['analytics'].to_openstruct if resp.has_key?('analytics')
        self.status     = resp['status']
        self.short_url  = resp['id']
      else
        raise exception("#{resp.code} #{resp.message}")
      end
    end

  end

end
