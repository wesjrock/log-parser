require_relative 'lib/parse'

path = 'log/games.log'

instance = Parse.new(path)
result = instance.output
puts result

