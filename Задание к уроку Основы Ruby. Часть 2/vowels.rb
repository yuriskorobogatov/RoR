alphabet = ('a'..'z').to_a
vowels = %w(a e i o u y)
hash = {}
alphabet.each.with_index(1) {|k,v|
  if vowels.include?(k)
  hash[k] = v end}
puts hash