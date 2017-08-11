puts "What is the length of the first side of the triangle?"
first = gets.chomp.to_f

puts "What is the length of the second side of the triangle?"
second = gets.chomp.to_f

puts "What is the length of the third side of the triangle?"
third = gets.chomp.to_f

if first==second&&second==third
  puts "Equilateral triangle"
else
  if first==second || second==third || first==third
    puts "Triangle isosceles"
  else

array = [first,second,third]
array_max=array.max
array.delete(array_max)

    if array_max**2==array[0]**2+array[1]**2
puts "This triangle is rectangular"

    end
  end
end
