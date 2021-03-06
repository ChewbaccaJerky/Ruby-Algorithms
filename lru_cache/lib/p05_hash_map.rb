require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    pos = self.bucket(key)
    @store[pos].include?(key)
  end

  def set(key, val)
    if num_buckets == @count
      resize!
    end

    pos = self.bucket(key)
    if @store[pos].include?(key)
      @store[pos].update(key, val)
    else
      @store[pos].append(key, val)
      @count += 1
    end
  end

  def get(key)
    pos = self.bucket(key)
    @store[pos].get(key)
  end

  def delete(key)
    pos = self.bucket(key)
    @store[pos].remove(key)
    @count -= 1
  end

  def each
    @store.each do |link_list|
      link_list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set



  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2){ LinkedList.new }
    self.each do |key, val|
      pos = key.hash % (num_buckets * 2)
      new_store[pos].append(key, val)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
