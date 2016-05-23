require 'sinatra'
require './lib/game'
require 'presenter_board'
class TTTWeb < Sinatra::Base
  enable :sessions

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
    board = session[:game].get_board
    @presenter_board = PresenterBoard.new(board)
    erb :play_move
  end

  post '/playmove' do
    @message = "That is not a valid move!" if !session[:game].play_move(params['move'].to_i - 1)
    session[:game].play_ai_turn
    @results = session[:game].results
    board = session[:game].get_board
    @presenter_board = PresenterBoard.new(board)

#   @presenter_board = PresenterBoard.new(seesion[:game].get_board)
    session[:game].game_over? ? (erb :play_again) : (erb :play_move)
  end
end
