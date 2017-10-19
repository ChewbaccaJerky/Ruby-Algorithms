require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @arr = []
    @capacity = 8
    @length = 0
    @startIdx = 0
  end

  # O(1)
  def [](index)
    if @length - 1 < index
      raise "index out of bounds"
    end
    
    if index < @length || @length > 0
      @arr[index]
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def []=(index, value)
    @arr[index] = value
  end

  # O(1)
  def pop
    if @length > 0
      @length -= 1
      @arr[@length]
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      @capacity = @capacity * 2
    end

    @arr[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise "index out of bounds"
    end

    shifted = @arr[0]
    @arr = @arr[1..-1]
    @length -= 1
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @arr = [val] + @arr
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if @length-1 < index
      raise "index out of bounds"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
