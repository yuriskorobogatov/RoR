print "What's your name?"
name = gets.chomp
print "How tall are you?"
tall = gets.chomp.to_i
ideal=tall - 110
if ideal < 0
  puts "Your weight,mr/ms #{name} is already optimal"
else
  puts "#{name}, your weight is #{ideal}"
end