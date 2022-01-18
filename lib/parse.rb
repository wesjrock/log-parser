class Parse
   def initialize(path)
      @path = path
      @lines = []
   end

   def fopen
      if File.exists?(@path)
         file = File.open(@path)
         @lines = file.readlines.map(&:chomp)
         file.close
      else
         return "ERROR: Invalid Path"
      end
   end

   def get_line
      return @lines[0]
   end

end
