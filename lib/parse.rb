require 'json'

class Parse
  def initialize(path)
    @path = path
    @lines = []
    @game_info = {}
  end

  def fopen
    if File.exist?(@path)
      file = File.open(@path)
      begin
        fread(file)
      rescue
        nil
      ensure
        file.close
      end
    end
  end

  def first_line
    @lines[0]
  end

  def output
    @game_info = {
      @path => {
        lines: count_lines(),
        players: [],
      }
    }
    obtain_player_name() 
    @game_info.to_json
  end

  private

  def fread(file)
    @lines = file.readlines.map(&:chomp)
  end

  def count_lines
    @lines.size
  end

  def obtain_player_name
    player_one_names = []
    player_two_names = []
    game_info_aux = @game_info[@path][:players] # OK

    for i in 0..@lines.size - 1
      if @lines.at(i).include?('killed')
        splitted_array = @lines.at(i).split('killed')

        player_one = splitted_array[0].split(':')
        player_one.slice!(0, 3)
        player_one[0].strip!
        player_one_names.push(player_one[0])

        player_two = splitted_array[1].split('by')
        player_two.delete_at(1)
        player_two[0].strip!
        player_two_names.push(player_two[0])
      end
    end

    game_info_aux << player_one_names.uniq << player_two_names.uniq
    @game_info[@path][:players] = game_info_aux
  end

end
