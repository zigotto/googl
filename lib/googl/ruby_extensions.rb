# Rails
class String
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end

# Hash to OpenStruct
# http://www.rubyquiz.com/quiz81.html
class Object
  def to_openstruct
    self
  end
end

class Array
  def to_openstruct
    map{ |el| el.to_openstruct }
  end
end

class Hash
  def move(from, to)
    self[to] = delete(from) if has_key?(from)
    self
  end  
  def to_openstruct
    map = inject({}) do |mapped, (key, value)| 
      mapped[key.underscore] = value.to_openstruct
      mapped.move('id', 'label')
    end
    OpenStruct.new(map)
  end
end
