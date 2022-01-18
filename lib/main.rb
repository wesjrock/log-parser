#./log/games.log

class Main
   def initialize(path)
      @path = path
   end

   def fopen
      if(File.exists?(@path))
         @file = File.open(@path)
         if(@file != nil)
            @line = @file.readlines.map(&:chomp)
            @file.close
         end
      else
         return "ERROR: Invalid Path"
      end
   end

   def get_line
      return @line[0]
   end

end
