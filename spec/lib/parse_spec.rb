require_relative '../spec_helper'
require_relative '../../lib/parse'

describe Parse do
  describe '#fopen' do
    context "when the file exists:" do
      it 'open the file' do
        parse = Parse.new("../../log/games.log")
        parse.fopen

        expect(parse.get_first_line()).to eq("  0:00 ------------------------------------------------------------")
      end
    end

    context "when the file doesn't exist:" do
      it "return an error message" do
        parse = Parse.new("invalid-path")
        parse.fopen

        expect(parse.fopen()).to eq(nil)
      end
    end
    
  end

  describe '#convert_to_json' do
    context "when counting line numbers:" do
      it "returns a JSON object" do
        parse = Parse.new("../../log/games.log")
        parse.fopen
        my_json_object = parse.output
        expected_json_object = {"../../log/games.log":{"lines":5306}}.to_json

        expect(my_json_object).to eq(expected_json_object)
      end
    end
  end

end
