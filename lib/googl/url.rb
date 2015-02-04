 module Googl
  class Url < Base
    def initialize(url_string)
      @url_string = url_string
      raise ArgumentError.new("URL is required") if url_string.nil? || url_string.strip.empty?
      url_string
    end

    def to_s
      @url_string
    end
  end
end
