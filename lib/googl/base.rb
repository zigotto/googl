module Googl

  class Base # :nodoc:

    private

    def modify_headers(item)
      Request.headers.merge!(item)
    end

  end

end
