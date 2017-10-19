class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc ||= prc
    @count = 0
  end

  def count
    @store.length
  end

  def extract
    # swap root with last item
    len = count
    if len > 0
      if len > 1
        temp = @store[0]
        @store[0] = @store[-1]
        @store[-1] = temp
      end
      val = @store.pop
      @store = self.class.heapify_down(@store, 0, &@prc)
      val
    end
    # heapify down
    # decrement count
  end

  def peek
    if count > 0
      @store[0]
    else
      false
    end
  end

  def push(val)
    # @heap.push(val)
    @store.push(val)
    # heapify_up
    @store = self.class.heapify_up(@store, count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    left = parent_index * 2 + 1
    right = parent_index * 2 + 2
    children = []
    children << left if left < len
    children << right if right < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    min = false
    if prc.nil?
      prc = Proc.new{|el1, el2| el1<=>el2}
      min = true
    end

    child_indices = self.child_indices(len, parent_idx)
    return array if child_indices.length == 0
    # get the right child_idx depending on heap property
    if child_indices.length == 2
      values = [ array[child_indices[0]], array[child_indices[1]] ]
      val = min ? values.min : values.max
      idx = values.find_index(val)
      child_idx = child_indices[idx]
    elsif child_indices.length == 1
      child_idx = child_indices[0]
    else
      return array
    end

    if prc.call(array[parent_idx], array[child_idx]) == 1
      array = swap(parent_idx, child_idx, array)
      if min
        self.heapify_down(array, child_idx)
      else
        self.heapify_down(array, child_idx, &prc)
      end
    else
      array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0

    if prc.nil?
      prc = Proc.new{|el1, el2| el1<=>el2}
    end

    parent_idx = self.parent_index(child_idx)
    if prc.call(array[parent_idx], array[child_idx]) == 1
      array = self.swap(parent_idx, child_idx, array)
      array = self.heapify_up(array, parent_idx, len = array.length, &prc)
    else
      array
    end
  end


  def self.swap(parent_idx, child_idx, array)
    temp = array[parent_idx]
    array[parent_idx] = array[child_idx]
    array[child_idx] = temp
    array
  end

end
