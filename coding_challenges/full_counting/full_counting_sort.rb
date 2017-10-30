def full_counting_sort
  hash = Hash.new
  array = []
  size = 0
  IO.readlines('test_file.txt').each do |line|
    temp = line.split(' ')
    if temp.length == 1
      size = temp[0].to_i
    else
      array << temp
    end
  end

  array.each_with_index do |item, idx|
    if idx < size/2
      if hash[item[0]]
        hash[item[0]].unshift('-')
      else
        hash[item[0]] = ['-']
      end
    else
      if hash[item[0]]
        hash[item[0]] << item[1]
      else
        hash[item[0]] = [item[1]]
      end
    end
  end

  hash.keys.sort.each do |key|
    hash[key].each do |val|
      print val + " "
    end
  end

end

full_counting_sort()
