lib = File.expand_path("../../lib", __FILE__)
$:.unshift(lib)

require 'sinatra'
require 'game'

set :root, File.join(File.dirname(__FILE__), '..')
set :views, Proc.new { File.join(root, "views") }

get '/' do
  game = Game.new
  @player_order = Game.player_order
  @player_choices = Game.player_choices
  erb :index
end

post '/newgame' do
  @@game = Game.new
  @@game.setup_game(params['Order'], params['Player2'])
  @@game.play_ai_turn
  @img = @@game.board_images
  erb :play_move
end

post '/playmove' do
  @message = "That is not a valid move!" if !@@game.play_move(params['move'].to_i - 1)
  @@game.play_ai_turn
  @img = @@game.board_images
  @results = @@game.results
  @@game.game_over? ? (erb :play_again) : (erb :play_move)
end
