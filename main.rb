require_relative 'lib/parse'

path = 'spec/fixtures/games.log'

instance = Parse.new(path)
result = instance.output
puts result

