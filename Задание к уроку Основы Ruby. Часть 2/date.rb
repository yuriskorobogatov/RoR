
  puts "Введите число месяца"
  day = gets.chomp.to_i

  puts "Введите месяц"
  month = gets.chomp.to_i

  puts "Введите год"
  year = gets.chomp.to_i

  month_arr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  if year % 4 == 0 && year % 100 !=0 || year % 400 == 0
    month_arr[1] = 29
  end

  counter = 1
  while counter < month do
    date += month_arr[counter - 1]
    counter += 1
  end
  puts "C начала года #{day + counter -1} дней"



