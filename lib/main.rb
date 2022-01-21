require_relative 'parse'

path = '../log/games.log'

instance = Parse.new(path)

if(File.exist?(path))
  result = instance.output
  puts result
end
