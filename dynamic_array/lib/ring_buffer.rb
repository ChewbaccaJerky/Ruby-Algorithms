require_relative "static_array"
require "byebug"
class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @arr = Array.new(@capacity)
  end

  # O(1)
  def [](index)
    if index < @start_idx || index > @length - 1 || @length == 0
      raise "index out of bounds"
    else
      @arr[index]
    end
  end

  # O(1)
  def []=(index, val)
    @arr[index] = val
  end

  # O(1)
  def pop
    if @length > 0
      @length -= 1
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
    end

    @arr[@length] = val
    @length += 1
  end

  # O(1)
  def shift
    if @length == 0
      raise "index out of bounds"
    end
    shifted = @arr[@start_idx]
    @start_idx = @start_idx % @capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    @start_idx -= 1
    @length += 1
    @arr[@start_idx] = val
    @arr[@start_idx]
    puts `value: #{@arr} idx: #{@start_idx}`

  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    newArr = Array.new(@capacity*2)
    @capacity.times do |i|
      newArr[i] = @arr[i]
    end
    @arr = newArr
    @capacity = @capacity * 2
    @start_idx = 0
  end
end
