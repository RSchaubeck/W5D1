class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    my_hash = (-1).hash # associate with empty array
    self.each_with_index do |ele, i|
      my_hash ^= (ele.to_s.hash + i).hash
    end
    my_hash
  end
end

class String
  def hash
    my_hash = (-1).hash
    self.each_char.with_index do |char, i|
      my_hash ^= (char.ord + i).hash
    end
    my_hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted_hash = self.sort_by {|key, val| key}
    hashes_arr = sorted_hash.map { |sub_arr| sub_arr.hash }
    hashes_arr.hash
  end
end
