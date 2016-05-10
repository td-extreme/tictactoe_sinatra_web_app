ENV['RACK_ENV'] = 'test'

require 'game'
require 'rack/test'

describe "Testing Tic Tac Toe sinatra web app" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let (:game) { double }

  it "Displays the welcome screen" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Welcome")
  end

  describe "New Game" do

    it "post /newgame returns a response" do
      app.class_variable_set("@@game", game)
      post '/newgame' 
      expect(last_response).to be_ok
    end
 
    it "Game is in playing mode after post /newgame" do
      app.class_variable_set("@@game", game)
      post '/newgame' 
      expect(last_response.body).to include("playmove")
    end
 end

  describe "playing the game" do
    it "Game asks to play again after it is over" do
      app.class_variable_set("@@game", game)
      allow(game).to receive(:play_move)
      allow(game).to receive(:play_ai_turn)
      allow(game).to receive(:is_current_player_ai?)
      allow(game).to receive(:get_board).and_return(['','','','','','','','',''])
      expect(game).to receive(:game_over?).and_return(true)
      allow(game).to receive(:tied_game?)
      allow(game).to receive(:winner)
      post '/playmove', 'move' => '3'
      expect(last_response.body).to include("New Game!")
    end
  end
end

