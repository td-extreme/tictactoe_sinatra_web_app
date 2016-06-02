require 'sinatra'
require './lib/game'
require './lib/index_presenter'
require './lib/play_move_presenter'
require './lib/play_again_presenter'
require './lib/game_setup'

class TTTWeb < Sinatra::Base
  enable :sessions

  get '/' do
    @presenter_index = IndexPresenter.new
    erb :index
  end

  post '/newgame' do
    setup = GameSetup.new(params['Order'], params['Player2'])
    session[:game] = setup.game
    @presenter = PlayMovePresenter.new(session[:game])
    erb :play_move
  end

  post '/playmove' do
    session[:game].play_round(params['move'].to_i - 1)
    redirect :board
  end

  get '/board' do
     if session[:game].game_over?
       @presenter = PlayAgainPresenter.new(session[:game])
       erb :play_again
    else
      @presenter = PlayMovePresenter.new(session[:game])
      erb :play_move
    end
  end
end
