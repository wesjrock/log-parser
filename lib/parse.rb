# frozen_string_literal: true

require 'json'

class Parse
  def initialize(path)
    @path = path
    @lines = []

    begin
      if File.exist?(@path)
        @lines = File.readlines(@path, chomp: true)
        @file = File.basename(@path)
      end
    rescue Errno::ENOENT
      puts 'Invalid Path'
    end
  end

  def obtain_first_line
    @lines[0]
  end

  def output
    game_info = {
      @file => {
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

    for i in 0..@lines.size - 1
      if @lines.at(i).include?('killed')
        splitted = @lines.at(i).split('killed')

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
    kills = []

    for i in 0..@lines.size - 1
      if @lines.at(i).include?('killed')
        splitted = @lines.at(i).split('killed')

        players_one = splitted[0].split(':')
        players_one.slice!(0, 3)
        players_one[0].strip!

        players_two = splitted[1].split('by')
        players_two.delete_at(1)
        players_two[0].strip!

        # Don't count <world> and also don't count when player kills himself
        if (players_one[0] != '<world>') && (players_one[0] != players_two[0])
          kills.push(players_one[0])
        end
      end
    end
    kills.tally
  end

  def count_total_kills
    total_kills = 0
    kills = count_kills
    
    kills.each do |_key, value|
      total_kills += value
    end
    total_kills
  end

end
