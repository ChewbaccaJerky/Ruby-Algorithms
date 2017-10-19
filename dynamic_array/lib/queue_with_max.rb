# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @length = 0
    @capacity = 8
    @arr = []
    @start_idx = 0
    @largest  = 0
  end

  def enqueue(val)
    if @largest < val
      @largest = val
    end
    @arr.push(val)
    @length += 1
  end

  def dequeue
    @start_idx += 1
    @length -= 1
    currentArr =  @arr[@start_idx..-1] += @arr[0...@length - (@capacity - @start_idx)]
    @max = currentArr.max
    puts currentArr
  end

  def max
    @largest
  end

  def length
    @length
  end

end
