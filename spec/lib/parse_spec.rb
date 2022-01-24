require_relative '../spec_helper'
require_relative '../../lib/parse'

path = '../../data/games.log'
invalid_path = 'invalid.rb'

describe Parse do
  describe '#obtain_first_line' do
    context 'when file exists:' do
      it 'return first line of the file' do
        parse = Parse.new(path)

        expect(parse.obtain_first_line).to eq('  0:00 ------------------------------------------------------------')
      end
    end

    context 'when file does not exist:' do
      it 'return an error' do
        parse = Parse.new(invalid_path)

        expect(parse.obtain_first_line).to eq(nil)
      end
    end
  end

  describe '#output' do
    context 'when file "games.log" exists:' do
      it 'returns JSON object' do
        parse = Parse.new(path)
        file_name = File.basename(path)
        json_object = parse.output
        expected_json_object = {
          "#{file_name}": {
            "lines":5306,
            "players": ["<world>","Isgalamido","Mocinha","Zeh","Dono da Bola","Assasinu Credi","Oootsimo","UnnamedPlayer","Maluquinho","Mal","Chessus"]
          }
        }.to_json

        expect(json_object).to eq(expected_json_object)
      end
    end
  end

end
