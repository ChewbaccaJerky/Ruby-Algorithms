require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if num_buckets == @count
      resize!
    end

    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    hash = num.hash
    pos = hash % num_buckets
    @store[pos]
  end

  def num_buckets
    @store.length
  end

  def resize!
    newStore = Array.new(num_buckets * 2){ Array.new }
    @store.each_with_index do |bucket, idx|
      next if bucket.length == 0
      bucket.each do |item|

        newStore[item.hash % num_buckets] = item
      end
    end
    @store = newStore
  end
end
