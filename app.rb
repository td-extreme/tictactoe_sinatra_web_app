require 'sinatra'
require './lib/game'
require './lib/presenter_board'
require './lib/presenter_index'
require './lib/presenter_play_move'
require './lib/presenter_play_again'

class TTTWeb < Sinatra::Base
  enable :sessions

  game = Game.new

  get '/' do
    @presenter_index = PresenterIndex.new
    erb :index
  end

  post '/newgame' do
    session[:game] = game
    session[:game].setup_game(params['Order'], params['Player2'])
    session[:game].play_ai_turn
    board = session[:game].get_board
    @presenter_board = PresenterBoard.new(board)
    @presenter_play_move = PresenterPlayMove.new
    erb :play_move
  end

  post '/playmove' do
    played_move = session[:game].play_move(params['move'].to_i - 1)
    session[:game].play_ai_turn
    @presenter_play_move = PresenterPlayMove.new(played_move)
    @presenter_play_again = PresenterPlayAgain.new(session[:game])
    board = session[:game].get_board
    @presenter_board = PresenterBoard.new(board)
    session[:game].game_over? ? (erb :play_again) : (erb :play_move)
  end
end
