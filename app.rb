require 'sinatra'
require './lib/game'
require './lib/index_presenter'
require './lib/play_move_presenter'
require './lib/play_again_presenter'

class TTTWeb < Sinatra::Base
  enable :sessions

  game = Game.new

  get '/' do
    @presenter_index = IndexPresenter.new
    erb :index
  end

  post '/newgame' do
    session[:game] = game
    session[:game].setup_game(params['Order'], params['Player2'])
    session[:game].play_ai_turn
    @presenter = PlayMovePresenter.new(game)
    erb :play_move
  end

  post '/playmove' do
    played_move = session[:game].play_move(params['move'].to_i - 1)
    session[:game].play_ai_turn
    if session[:game].game_over?
      redirect :play_again
    else
      @presenter = PlayMovePresenter.new(session[:game], played_move)
      erb :play_move
    end
  end

  get '/play_again' do
    @presenter = PlayAgainPresenter.new(session[:game])
    erb :play_again
  end
end
