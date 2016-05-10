require 'sinatra'
require 'tictactoe'

set :root, File.join(File.dirname(__FILE__), '..')
set :views, Proc.new { File.join(root, "views") }


Player_Order = {
  'P1' => 'Player',
  'P2' => 'Opponent',
}

Player_Choices = {
  'HUMAN' => 'Human',
  'EASY' => 'Computer AI Easy',
  'HARD' => 'Computer AI Hard',
}

get '/' do
  erb :index
end

post '/newgame' do
  setup_game(params['Order'], params['Player2'])
  play_ai_turn
  update_board_images
  playing_game
  erb :board
end

post '/playmove' do
  @results = "That is not a valid move!" if !@@game.play_move(params['move'].to_i - 1)
  play_ai_turn
  update_board_images
  @@game.game_over? ? end_of_game : playing_game
  erb :board
end

private

def end_of_game
  if @@game.tied_game?
    @results = "Tied Game!"
  else
    @results = "Player #{@@game.winner} is the Winner!"
  end
  @board_form = "<form action=\"/ \" method=\'get\'><button type=\'submit\' class=\'btn btn-primary\'>New Game!</button></form>"
end

def playing_game
  @board_form = "<form action=\"playmove\" method=\'post\'><textarea name=\"move\" cols=\"1\" rows=\"1\"></textarea><button type=\'submit\' class=\'btn btn-primary\'>Play Move!</button></form>"
end

def play_ai_turn
  @@game.play_move(@@game.get_ai_player_move) if @@game.is_current_player_ai? && !@@game.game_over?
end

def update_board_images
  @img = []
  @@game.get_board.each.with_index do |val, i|
    case val
    when :X
      @img[i] = "<img src=\"X.png\" alt=\"X\"  height=\"128\" width=\"128\">"
    when :O
      @img[i] = "<img src=\"O.png\" alt=\"O\"  height=\"128\" width=\"128\">"
    else
      @img[i] = "<img src=\"number#{i+1}.png\" alt=\"#{i+1}\"  height=\"128\" width=\"128\">"
    end
  end
end

def setup_game(order, player2)
  if order == 'P1'
    player1 = :HUMAN
  else
    player1 = player2
    player2 = :HUMAN
  end
  @@game = TicTacToe.new(player1, player2)
end
