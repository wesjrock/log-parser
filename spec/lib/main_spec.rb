require_relative '../spec_helper'
require_relative '../../lib/main'

describe Main do
    context "When the file exists:" do
        it 'Open the file, Read it and Print the first line' do
            #Input
            main = Main.new("../../log/games.log")
            main.fopen

            #Output
            expect(main.get_line()).to eq("  0:00 ------------------------------------------------------------")
        end
    end

    context "When the file doesn't exist:" do
        it "Return an error message" do
            #Input
            main = Main.new("invalid-path")
            main.fopen

            #Output
            expect(main.fopen()).to eq("ERROR: Invalid Path")
        end
    end

end
