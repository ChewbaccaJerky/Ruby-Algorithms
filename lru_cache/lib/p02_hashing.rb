class Fixnum
  # Fixnum#hash already implemented for you

end

class Array
  def hash
    hash_value = 0
    self.each_with_index do |val, idx|
      hash_value += val.hash ** idx
    end
    hash_value
  end
end

class String
  def hash
    hash_value = 0
    self.chars.each_with_index do |ch, idx|
      hash_value += ch.ord ** idx
    end
    return hash_value
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_value = 0
    self.values.each_with_index do |val, idx|
      hash_value += val.hash
    end
    hash_value
  end
end
