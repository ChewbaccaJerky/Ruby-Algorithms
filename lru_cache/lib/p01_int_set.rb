class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max){false}
  end

  def insert(num)
    unless include?(num)
      if is_valid?(num)
        @store[num] = true
        true
      else
        raise "Out of bounds"
      end
    else
      false
    end
  end

  def remove(num)
    if include?(num)
      @store[num] = false
    end
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    return num < @max && num >= 0
  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @store[@count] = num
      @count += 1
      return true
    end
    false
  end

  def remove(num)
    if self[num]
      idx = self[num]
      @store = @store[0...idx] + @store[idx+1..-1]
    end
  end

  def include?(num)
    @store.each do |val|
      return true if val == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store.each_with_index do |item, bucket_num|
      return bucket_num if num == item
    end
    false
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if num_buckets == @count
      resize!
    end

    self[num] << num
    @count += 1
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    pos = num % num_buckets
    @store[pos]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets){ Array.new }
    @store.each do |item|
      next if item.length == 0
      item.each do |val|
        pos = val % new_buckets
        new_store[pos] << val
      end
    end
    @store = new_store
  end
end
