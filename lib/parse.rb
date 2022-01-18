class Parse
   def initialize(path)
      @path = path
      @line = []
   end

   def fopen
      if File.exists?(@path)
         file = File.open(@path)
         @line = file.readlines.map(&:chomp)
         file.close
      else
         return "ERROR: Invalid Path"
      end
   end

   def get_line
      return @line[0]
   end

end
