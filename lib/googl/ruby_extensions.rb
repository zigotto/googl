# Rails
module StringHelper
  def self.underscore(str)
    str.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
  end
end

# Hash to OpenStruct
# http://www.rubyquiz.com/quiz81.html
class Object # :nodoc:
  def to_openstruct
    self
  end
end

class Array # :nodoc:
  def to_openstruct
    map{ |el| el.to_openstruct }
  end
end

class Hash #:nodoc:
  def move(from, to)
    self[to] = delete(from) if has_key?(from)
    self
  end  
  def to_openstruct
    map = inject({}) do |mapped, (key, value)| 
      mapped[StringHelper.underscore(key)] = value.to_openstruct
      mapped.move('id', 'label')
    end
    OpenStruct.new(map)
  end
end
