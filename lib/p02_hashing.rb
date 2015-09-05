class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    accum = 0.hash
    self.each_with_index do |item, index|
      accum += item.hash * index
    end
    accum
  end
end

class String
  def hash
    self.split("").map { |letter| letter.ord }.hash
  end
end

class Hash
  def hash
    accum = 0
    self.each do |key, val|
      accum += key.hash * val.hash
    end
    accum
  end
end
