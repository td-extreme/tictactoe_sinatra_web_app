root = File.expand_path("../..", __FILE__)
$:.unshift(root)

lib = File.expand_path("../../lib", __FILE__)
$:.unshift(lib)

require 'app'
require 'board_images'
require 'game'
require 'index_presenter'
require 'play_again_presenter'
require 'play_move_presenter'
