root = File.expand_path("..", __FILE__)
$:.unshift(root)

lib = File.expand_path("../lib", __FILE__)
$:.unshift(lib)

require './app.rb'
TTTWeb.run!
