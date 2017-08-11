print "Первый коэффициент?"
a = gets.chomp.to_i

print "Второй коэффициент?"
b = gets.chomp.to_i

print "Третий коэффициент?"
c  = gets.chomp.to_i

d = b**2 - (4 * a * c)
if d < 0
  puts "Дискриминант равен #{d}, корней нет"
else


  x1 = (-b - Math.sqrt(d))/(2 * a)
  x2 = (-b + Math.sqrt(d))/(2 * a)
  if d > 0
    puts "Дискриминант равен #{d}, корни квадратного уравнения #{x1} и #{x2}"
  elsif d == 0
    puts "Дискриминант равен #{d}, единственный корень квадратного уравнения #{x1}"
  end
end
