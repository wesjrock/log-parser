require_relative 'parse'

path = '../log/games.log'

instance = Parse.new(path)
instance.fopen
instance.output

result = instance.output
puts result

