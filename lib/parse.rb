require 'json'

class Parse
   def initialize(path)
      @path = path
      @lines = []
      @line_count = 0
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

   def get_line
      return @lines[0]
   end

   def count_lines
      @line_count = @lines.size
      convert_to_json()
   end

   def convert_to_json
      my_object = {
         "#{@path}": {
         lines: @line_count
         } 
      }
      json_object = my_object.to_json
   end

end
