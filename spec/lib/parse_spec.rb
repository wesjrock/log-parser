require_relative '../spec_helper'
require_relative '../../lib/parse'

describe Parse do
    describe '#fopen' do
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
    end
end

