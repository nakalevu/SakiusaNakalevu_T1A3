if ARGV[0] == 'answers'
  file = File.open("answers.txt")
  puts file.read
end

file = File.open("answers.txt")
  puts file.read