require_relative "heap"

class Array
  def heap_sort!
    cur_idx = 0
    arr = self.dup

    prc = Proc.new do |el1, el2|
      -1 * (el1 <=> el2)
    end

    arr.each_index do |idx|
      arr = BinaryMinHeap.heapify_up(arr, idx, idx + 1, &prc)
    end
    # puts arr.object_id
    len = arr.length - 1
    arr.each_index do |idx|
      next if idx == arr.length - 1
      arr = BinaryMinHeap.swap(0, len - idx, arr)
      print "after swap   #{arr}"
      puts ""
      rest = arr[len-idx..-1]
      arr = BinaryMinHeap.heapify_down(arr[0..(len-idx-1)], 0, &prc)
      arr = arr + rest
      print "after h_down #{arr}"
      puts ""
      puts "-------------------"
      # puts arr.object_id
    end
    arr
  end
end
