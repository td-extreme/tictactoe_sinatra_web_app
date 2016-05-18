lib = File.expand_path("../../lib", __FILE__)
$:.unshift(lib)

require 'sinatra'
require 'game'

class GameController < Sinatra::Base
  enable :sessions
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }

  game = Game.new

  get '/' do
    @player_choices = Game::PLAYER_CHOCIES
    @player_order = Game::PLAYER_ORDER
    erb :index
  end

  post '/newgame' do
    session[:game] = game
    session[:game].setup_game(params['Order'], params['Player2'])
    session[:game].play_ai_turn
    @images = session[:game].board_images
    erb :play_move
  end

  post '/playmove' do
    @message = "That is not a valid move!" if !session[:game].play_move(params['move'].to_i - 1)
    session[:game].play_ai_turn
    @results = session[:game].results
    @images = session[:game].board_images
    session[:game].game_over? ? (erb :play_again) : (erb :play_move)
  end
end
