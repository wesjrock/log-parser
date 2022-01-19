# Required
1. Install Ruby (3.1.0): https://rvm.io
2. Install Rspec and Json support: Run the command 'bundle'

# Running the Aplication
Run
```
irb
require_relative 'parse'
my_instance = Parse.new("file path")
my_instance.fopen
my_instance.convert_to_json
```

# Running the Test
Go into the folder
```
log-parser/spec/lib
```
Run
```
rspec parse_spec.rb
```
