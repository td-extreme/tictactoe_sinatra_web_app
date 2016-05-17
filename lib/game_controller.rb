lib = File.expand_path("../../lib", __FILE__)
$:.unshift(lib)

require 'sinatra'
require 'game'

class GameController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }

  game = Game.new

  get '/' do
    @player_choices = Game.player_choices
    @player_order = Game.player_order
    erb :index
  end

  post '/newgame' do
    game.setup_game(params['Order'], params['Player2'])
    game.play_ai_turn
    @images = game.board_images
    erb :play_move
  end

  post '/playmove' do
    @message = "That is not a valid move!" if !game.play_move(params['move'].to_i - 1)
    game.play_ai_turn
    @results = game.results
    @images = game.board_images
    game.game_over? ? (erb :play_again) : (erb :play_move)
  end
end
