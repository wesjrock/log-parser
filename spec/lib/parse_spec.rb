require_relative '../spec_helper'
require_relative '../../lib/parse'

describe Parse do
    
        context "when the file exists:" do
            it 'open the file' do
                #Input
                parse = Parse.new("../../log/games.log")
                parse.fopen

                #Output
                expect(parse.get_line()).to eq("  0:00 ------------------------------------------------------------")
            end
        end

        context "when the file doesn't exist:" do
            it "return an error message" do
                #Input
                parse = Parse.new("invalid-path")
                parse.fopen

                #Output
                expect(parse.fopen()).to eq(nil)
            end
        end
    
        context "when counting line numbers:" do
            it "returns a JSON object" do
                #Input
                parse = Parse.new("../../log/games.log")
                parse.fopen
                my_json_object = parse.count_lines
                expected_json_object = {"../../log/games.log":{"lines":5306}}.to_json

                #Output
                expect(my_json_object).to eq(expected_json_object)
            end
        end

end

