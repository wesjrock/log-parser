require 'json'

class Parse
  def initialize(path)
    @path = path
    @lines = []
    @game_info = {}

    begin
      file = File.open(@path)
      @lines = file.readlines.map(&:chomp)
    rescue Errno::ENOENT
      puts 'Invalid Path'
    end
  end

  def obtain_first_line
    @lines[0]
  end

  def output
    @game_info = {
      @path => {
        lines: count_lines(),
        players: obtain_player_names(),
      }
    }
    @game_info.to_json()
  end

  private

  def count_lines
    @lines.size()
  end

  def obtain_player_names
    game_info_aux = []

    for i in 0..@lines.size - 1
      if @lines.at(i).include?('killed')
        splitted = @lines.at(i).split('killed')

        players_one = splitted[0].split(':')
        players_one.slice!(0, 3)
        players_one[0].strip!()

        players_two = splitted[1].split('by')
        players_two.delete_at(1)
        players_two[0].strip!()

        game_info_aux.push(players_one[0], players_two[0])
      end
    end
    game_info_aux.uniq()
  end

end
