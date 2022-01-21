require_relative '../spec_helper'
require_relative '../../lib/parse'

path = '../../log/games.log'
invalid_path = 'invalid.rb'

describe Parse do
  describe '#fopen' do
    context 'when file exists:' do
      it 'open it' do
        parse = Parse.new(path)
        parse.fopen

        expect(parse.first_line).to eq('  0:00 ------------------------------------------------------------')
      end
    end

    context 'when file does not exist:' do
      it 'return an error message' do
        parse = Parse.new(invalid_path)
        parse.fopen

        expect(parse.fopen).to eq(nil)
      end
    end
end

  describe '#convert_to_json' do
    context 'when counting number of lines:' do
      it 'returns JSON object' do
        parse = Parse.new(path)
        parse.fopen
        json_object = parse.output
        expected_json_object = {
          "#{path}": {
            "lines":5306,
            "players": ["<world>","Isgalamido","Mocinha","Zeh","Dono da Bola","Assasinu Credi","Oootsimo","UnnamedPlayer","Maluquinho","Mal","Chessus"]
          }
        }.to_json

        expect(json_object).to eq(expected_json_object)
      end
    end
  end

end
