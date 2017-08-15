fibonacci = [0,1]

while (num = fibonacci[-1] + fibonacci[-2]) < 100 do
  fibonacci.push(num)
end

puts fibonacci