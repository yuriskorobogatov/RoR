i = 5
loop do
  i += 5
  next if i % 5 != 0
  print "#{i}"
  break if i == 100
end
