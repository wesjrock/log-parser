# frozen_string_literal: true

require 'json'

class Parse
  def initialize(path)
    @path = path
    @lines = []
    @file_name = ''

    if File.exist?(@path)
      @lines = File.readlines(@path, chomp: true)
      @file_name = File.basename(@path)
    else
      raise 'File not found'
    end

  end

  def obtain_first_line
    @lines[0]
  end

  def output
    game_info = {
      @file_name => {
        lines: count_lines,
        players: obtain_player_names,
        kills: count_kills,
        total_kills: count_total_kills
      }
    }
    game_info.to_json
  end

  private

  def count_lines
    @lines.size
  end

  def obtain_player_names
    game_info_aux = []

    @lines.each do |line|
      if line.include?('killed')
        splitted = line.split('killed')
        players_one = splitted[0].split(':')
        players_one.slice!(0, 3)
        players_one[0].strip!

        players_two = splitted[1].split('by')
        players_two.delete_at(1)
        players_two[0].strip!

        if (players_one[0] || players_two[0]) != '<world>'
          game_info_aux.push(players_one[0], players_two[0])
        end
      end
    end
    game_info_aux.uniq
  end

  def count_kills
    players_and_kills = {}

    @lines.each do |line|
      if line.include?('killed')
        splitted = line.split('killed')

        players_one = splitted[0].split(':')
        players_one.slice!(0, 3)
        players_one[0].strip!

        players_and_kills.store(players_one[0], 0)
      end
    end

    @lines.each do |line|
      players_and_kills.each {|key, value|
        if line.include?("#{key} killed")
          players_and_kills.store(key, value + 1)
        elsif line.include?("<world> killed #{key}")
          players_and_kills.store(key, value - 1)
        end
      }
    end
    players_and_kills.delete('<world>')
    players_and_kills
  end

  def count_total_kills
    total_kills = 0

    @lines.each do |line|
      if line.include?('killed')
        total_kills += 1
      end
    end
    total_kills
  end

end
