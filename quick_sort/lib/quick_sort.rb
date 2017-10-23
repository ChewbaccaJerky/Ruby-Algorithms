require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = array[0]
    left = array[1..-1].select{|item| item < pivot}
    right = array[1..-1].select{|item| item >= pivot}

    return self.sort(left) + [pivot] + self.sort(right)
  end

  # In-place.
  $stack_level = -1
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1

    pivot = partition(array, start, length, &prc)
    sort2!(array, 0, pivot, &prc)
    sort2!(array, pivot + 1, (length - pivot - 1), &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    puts rand(length)
    if prc.nil?
      prc = Proc.new{|e1, e2| e1 <=> e2 }
    end
    # pivot = rand(length) + start - 1
    # temp = array[pivot]
    # array[pivot] = array[start]
    # array[start] = temp
    pivot = start
    barrier = start
    length.times do |i|
      if prc.call(array[start + i], array[pivot]) == -1
        barrier += 1
        if barrier != (start + i)
          temp = array[barrier]
          array[barrier] = array[start + i]
          array[start + i] = temp
        end
      end
    end

    #move pivot
    if pivot != barrier
      temp = array[pivot]
      array[pivot] = array[barrier]
      array[barrier] = temp
    end
    pivot = barrier
    pivot
  end
end
