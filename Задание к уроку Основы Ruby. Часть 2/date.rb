def date
  puts "Число?"
  day = gets.chomp.to_i
  puts "Месяц?"
  month = gets.chomp.to_i
  puts "Год?"
  year = gets.chomp.to_i

  month_array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  if year % 4 == 0 && year % 100 !=0 || year % 400 == 0
    month_array[1] = 29
  end

  n = 0
  x = 0

  while x < month
    n += month_array[x]
    x += 1
  end

  n+= day

  puts "С начала года #{day + n} дней"
end
date