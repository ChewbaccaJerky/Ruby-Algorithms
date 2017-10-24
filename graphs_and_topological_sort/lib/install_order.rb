# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to



def install_order(arr)
  hash = Hash.new
  arr.each do |tup|
    if hash[tup[0]].nil?
      hash[tup[0]] = []
    end
    if hash[tup[1]]
      hash[tup[1]].push(tup[0])
    else
      hash[tup[1]] = [tup[0]]
    end
  end
  max = hash.keys.max
  #insert missing nodes
  (1..max).each do |i|
    unless hash[i]
      hash[i] = []
    end
  end

  install = []
  hash.each do |k, v|
    install.push(k) unless install.include?(k)
    v.each do |id|
      install.push(id) unless install.include?(id)
    end
  end
  install
end
