module Googl

  class Base
    
    # URL for QR Code
    #
    #   url = Googl.shorten('http://goo.gl/ump4S')
    #   ur.qr_code
    #   => http://goo.gl/ump4S.qr
    #
    # Usage:
    #
    #   <img src="http://goo.gl/ump4S.qr" />
    #
    def qr_code
      "#{short_url}.qr"
    end

    # URL for analytics
    #
    #   url = Googl.shorten('http://goo.gl/ump4S')
    #   ur.info
    #   => http://goo.gl/ump4S.info
    #
    def info
      "#{short_url}.info"
    end

    private

    def modify_headers(item)
      Request.headers.merge!(item)
    end

  end

end
