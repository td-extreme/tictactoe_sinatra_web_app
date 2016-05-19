require 'tictactoe'

class Game
  extend Forwardable

  def_delegators :@ttt, :game_over?, :play_move, :get_board

  PLAYER_ORDER = {
    :P1 => 'Player',
    :P2 => 'Opponent',
  }

  PLAYER_CHOCIES = {
    :HUMAN => 'Human',
    :EASY => 'Computer AI Easy',
    :HARD => 'Computer AI Hard',
  }

  def results
    @ttt.tied_game? ? "Tied Game!" : "Player #{@ttt.winner} is the Winner!"
  end

  def play_ai_turn
    @ttt.play_move(@ttt.get_ai_player_move) if @ttt.is_current_player_ai? && !@ttt.game_over?
  end

  def setup_game(order, player2)
    if order == 'P1'
      player1 = :HUMAN
    else
      player1 = player2
      player2 = :HUMAN
    end
    @ttt = TicTacToe.new(player1, player2)
  end
end
