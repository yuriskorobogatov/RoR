alphabet = ('a'..'z').to_a
vowels = %w(a e i o u y)
hash = {}
alphabet.each.with_index do |letter, index|
  hash[letter] = index if vowels.include?(letter)
  end
puts hash