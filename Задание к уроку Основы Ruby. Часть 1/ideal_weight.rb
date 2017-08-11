print "What's your name?"
name = gets.chomp

print "How tall are you?"
tall = Integer(gets.chomp)



if (tall - 110 < 0)

  puts "Your weight,mr/ms #{name} is already optimal"

else

  puts "#{name}, your weight is #{tall-110}"

end