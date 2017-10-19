require_relative 'heap'

def k_largest_elements(array, k)
  prc = Proc.new do |el1, el2|
    -1 * (el1 <=> el2)
  end
  heap = BinaryMinHeap.new(&prc)
  k_largest = []
  array.each do |item|
    heap.push(item)
  end
  k.times do |i|
    k_largest.push(heap.extract)
  end
  print k_largest
  puts ""
  k_largest
end
