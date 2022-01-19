require 'json'

class Parse
   def initialize(path)
      @path = path
      @lines = []
   end

   def fopen
      if File.exists?(@path)
         file = File.open(@path)
         begin
            @lines = file.readlines.map(&:chomp)
         rescue
            return nil
         ensure
            file.close
         end
      end
   end

   def get_first_line
      return @lines[0]
   end

   def convert_to_json
      my_object = {
         "#{@path}": {
         lines: count_lines()
         } 
      }
      json_object = my_object.to_json
   end

   private

   def count_lines
      @lines.size
   end   

end
