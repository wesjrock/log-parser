# frozen_string_literal: true

require_relative 'lib/parse'

path = 'data/games.log'

instance = Parse.new(path)
result = instance.output
puts result

