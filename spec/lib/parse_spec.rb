# frozen_string_literal: true

require_relative '../../lib/parse'

describe Parse do
  let(:path) { 'data/games.log' }
  let(:invalid_path) { 'invalid.rb' }

  describe '#obtain_first_line' do
    context 'when file exists:' do
      it 'return its first line' do

        expect(Parse.new(path).obtain_first_line).to eq('  0:00 ------------------------------------------------------------')
      end
    end
  end

  describe '#initialize' do
    context 'when file does not exist:' do
      it 'return an error' do
        error_message = 'File not found'

        expect{Parse.new(invalid_path)}.to raise_error(error_message)
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
            "lines": 5306,
            "players": ["Isgalamido","Mocinha","Dono da Bola","Zeh","Assasinu Credi","Oootsimo","UnnamedPlayer","Maluquinho","Mal","Chessus"],
            "kills":{"Isgalamido":147,"Dono da Bola":63,"Zeh":124,"Assasinu Credi":111,"Oootsimo":114,"Maluquinho":0,"Mal":-4,"Chessus":33},
            "total_kills":1069
          }
        }.to_json

        expect(json_object).to eq(expected_json_object)
      end
    end
  end

end
