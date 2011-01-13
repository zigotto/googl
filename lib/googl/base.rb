module Googl

  class Base

    private

    def modify_headers(item)
      Request.headers.merge!(item)
    end

  end

end
