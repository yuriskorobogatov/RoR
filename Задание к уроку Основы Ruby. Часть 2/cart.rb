basket = {}
total = 0
loop do
  puts "Введите наименование товара и стоп когда список покупок окончен"
  name = gets.chomp
  break if name == 'стоп'
  puts "Количество товара"
  quantity = gets.chomp.to_f
  puts "Цена за единицу товара"
  price = gets.chomp.to_f
  cost = price * quantity
  total += cost
  basket[name] = {price: price, quantity: quantity}
end

basket.each do |name, description|
  puts "#{name} #{description[:quantity]}	#{description[:price]} #{description[:price] * description[:quantity]}"
end
puts "Итого в корзине: #{total}"