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

   def get_line
      return @lines[0]
   end

end
