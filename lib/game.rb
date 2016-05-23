require 'tictactoe'

class Game
  extend Forwardable

  def_delegators :@ttt,:tied_game?, :game_over?, :play_move, :get_board, :winner

  def play_ai_turn
    @ttt.play_move(@ttt.get_ai_player_move) if @ttt.is_current_player_ai? && !@ttt.game_over?
  end

  def setup_game(order, player2)
    if order == "p1"
      player1 = :human
    else
      player1 = player2
      player2 = :human
    end
    @ttt = TicTacToe.new(player1, player2)
  end
end
