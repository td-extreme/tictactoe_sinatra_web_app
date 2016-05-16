ENV['RACK_ENV'] = 'test'
require 'sinatra'
require 'rack/test'
require 'game_controller'

describe "Testing Tic Tac Toe sinatra web app" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let (:game) { double }

  it "Displays the welcome screen" do
    test_options = { 'd1' => 'dummy' }
    subject.instance_variable_set("@player_order", test_options)
    subject.instance_variable_set("@player_choices", test_options)
    get '/'
    expect(last_response).to be_ok
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
      allow(game).to receive(:results)
      allow(game).to receive(:board_images).and_return(['','','','','','','','',''])
      expect(game).to receive(:game_over?).and_return(true)
      post '/playmove', 'move' => '3'
      expect(last_response.body).to include("New Game!")
    end
  end
end
