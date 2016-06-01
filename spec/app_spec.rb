ENV['RACK_ENV'] = 'test'
require 'sinatra'
require 'rack/test'
require './app'

describe TTTWeb do
  include Rack::Test::Methods

  def app
    TTTWeb
  end

  it "Displays the welcome screen" do
    get '/'
    expect(last_response).to be_ok
  end

  describe "New Game" do
    it "post /newgame returns a response" do
      post '/newgame', 'Order' => :P1, 'Player2' => :human
      expect(last_response).to be_ok
    end

    it "Game is in playing mode after post /newgame" do
      post '/newgame', 'Order' => :P1, 'Player2' => :human
      expect(last_response.body).to include("playmove")
    end
  end
  describe "playing the game" do
    it "Game asks to play a New Game after it is over" do
      post '/newgame', 'Order' => :P1, 'Player2' => :human
      for i in 0..8
       post '/playmove', 'move' => i
      end 
      get '/board'
      expect(last_response.body).to include("New Game")
    end

    it "It has a play move button while the game is happening" do
      post '/newgame', 'Order' => :P1, 'Player2' => :human
      expect(last_response.body).to include("Play Move")
    end
  end
end
