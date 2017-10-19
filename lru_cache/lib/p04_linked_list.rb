class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    @prev = nil
    @next = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @count = 0
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @count == 0
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)

    new_node.next = @tail
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    @tail.prev = new_node
    @count += 1

    new_node
  end

  def update(key, val)
    if include?(key)
      self.each do |node|
        node.key = key
        node.val = val
      end
    end
  end

  def remove(key)
    self.each do |node|
      node.key
      if key == node.key
        node.remove
        @count -= 1
        return true
      end
    end
    return false
  end

  def each
    node = first
    while node != @tail
      yield(node)
      node = node.next
    end
  end

  def each_with_index
    i = 0
    self.each do |node|
      yield(node, i)
      i += 1
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
