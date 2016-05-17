ENV['RACK_ENV'] = 'test'
require 'sinatra'
require 'rack/test'
require 'game_controller'

describe GameController do
  include Rack::Test::Methods

  def app
    GameController
  end

  it "Displays the welcome screen" do
    get '/'
    expect(last_response).to be_ok
  end

  describe "New Game" do
    it "post /newgame returns a response" do
      post '/newgame', 'Order' => :P1, 'Player2' => :HUMAN
      expect(last_response).to be_ok
    end

    it "Game is in playing mode after post /newgame" do
      post '/newgame', 'Order' => :P1, 'Player2' => :HUMAN
      expect(last_response.body).to include("playmove")
    end
 end

  describe "playmove" do
    it "displays that is an invalid move if user inputs a move already played" do
      post '/newgame', 'Order' => :P1, 'Player2' => :HUMAN
      post '/playmove', 'move' => '4'
      post '/playmove', 'move' => '4'
      expect(last_response.body).to include("not a valid move")
    end

    it "does NOT display invalid message if move is allowed" do
      post '/newgame', 'Order' => :P1, 'Player2' => :HUMAN
      post '/playmove', 'move' => '4'
      expect(last_response.body).not_to include("not a valid move")
    end
  end

  describe "playing the game" do
    it "Game asks to play a New Game after it is over" do
       post '/newgame', 'Order' => :P1, 'Player2' => :HUMAN
       (1..9).each do |i|
        post '/playmove', 'move' => i
       end
      expect(last_response.body).to include("New Game")
    end

    it "It has a play move button while the game is happening" do
       post '/newgame', 'Order' => :P1, 'Player2' => :HUMAN
      expect(last_response.body).to include("Play Move")
    end
  end
end
