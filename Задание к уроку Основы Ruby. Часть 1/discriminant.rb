print "Первый коэффициент?"
a = gets.chomp.to_i
print "Второй коэффициент?"
b = gets.chomp.to_i
print "Третий коэффициент?"
c  = gets.chomp.to_i
d = b**2 - (4 * a * c)
if d < 0
  puts "Дискриминант равен #{d}, корней нет"
end
if d > 0
  sqrt_my=Math.sqrt(d);
  x1 = (-b - sqrt_my)/(2 * a)
  x2 = (-b + sqrt_my)/(2 * a)
  puts "Дискриминант равен #{d}, корни квадратного уравнения #{x1} и #{x2}"
end
if d == 0
  x=-b / (2 * a)
  puts "Дискриминант равен #{d}, единственный корень квадратного уравнения #{x}"
end
