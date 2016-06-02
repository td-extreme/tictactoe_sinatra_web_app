require 'tictactoe'
class Game
  extend Forwardable

  def_delegators :@ttt,:tied_game?, :game_over?, :play_move, :get_board, :winner, :valid_move?, :available_moves, :get_game_state

  def initialize(rules, board, opponent, order)
    @ai_player = opponent
    @ttt = TicTacToe.new(rules, board)
    play_ai_move if order == "p2" && @ai_player != :human
  end

  def play_round(move)
    if valid_move?(move)
      play_move(move)
      play_ai_move if !(game_over?) && @ai_player != :human
    end
  end

  def play_ai_move
    game_state = get_game_state
    move = ai_player.get_move(game_state)
    play_move(move)
  end

  private
  attr_accessor :ttt, :ai_player
end
