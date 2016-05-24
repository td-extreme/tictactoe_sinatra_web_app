require 'sinatra'
require './lib/game'
require './lib/index_presenter'
require './lib/game_view_selector'
# require './lib/board_images'
# require './lib/play_move_presenter'
# require './lib/play_again_presenter'

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
    load_game_view(true)
  end

  post '/playmove' do
    played_move = session[:game].play_move(params['move'].to_i - 1)
    session[:game].play_ai_turn
    load_game_view(played_move)
  end

  private 
  
  def load_game_view(played_move)
    selector = GameViewSelector.new(session[:game], played_move)
    @presenter = selector.presenter
    erb selector.view
  end
end
