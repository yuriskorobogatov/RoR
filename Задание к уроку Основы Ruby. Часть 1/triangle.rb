print "What is the length of the first side of the triangle?"
first = gets.chomp.to_i

print "What is the length of the second side of the triangle?"
second = gets.chomp.to_i

print "What is the length of the third side of the triangle?"
third = gets.chomp.to_i

c = [first,second,third].max

if (c**2 == second**2 + third**2 || c**2 == first**2 + third**2 || c**2 == first**2 + second**2)
  puts "This triangle is rectangular"
  end
if (first == second || first == third || third == second)
  puts "Equilateral triangle"
end