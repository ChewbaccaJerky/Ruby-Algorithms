require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash_map = HashMap.new
  string.each_char do |ch|
    unless hash_map.include?(ch)
      hash_map.set(ch, 1)
    else
      hash_map.delete(ch)
    end
  end

  if hash_map.count == 0 || hash_map.count == 1
    true
  else
    false
  end
end
