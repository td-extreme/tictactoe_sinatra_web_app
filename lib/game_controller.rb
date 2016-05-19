lib = File.expand_path("../../lib", __FILE__)
$:.unshift(lib)

require 'sinatra'
require 'game'
require 'board_images'
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
    @images = BoardImages::get_images(session[:game].get_board)
    erb :play_move
  end

  post '/playmove' do
    @message = "That is not a valid move!" if !session[:game].play_move(params['move'].to_i - 1)
    session[:game].play_ai_turn
    @results = session[:game].results
    @images = BoardImages::get_images(session[:game].get_board)
    session[:game].game_over? ? (erb :play_again) : (erb :play_move)
  end
end
