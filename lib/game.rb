require 'tictactoe'

class Game

  attr_accessor :ttt

  Player_Order = {
    :P1 => 'Player',
    :P2 => 'Opponent',
  }

  Player_Choices = {
    :HUMAN => 'Human',
    :EASY => 'Computer AI Easy',
    :HARD => 'Computer AI Hard',
  }

  def self.player_order
    Player_Order
  end

  def self.player_choices
    Player_Choices
  end

  def game_over?
    @ttt.game_over?
  end

  def results
    @ttt.tied_game? ? "Tied Game!" : "Player #{@ttt.winner} is the Winner!"
  end

  def play_ai_turn
    @ttt.play_move(@ttt.get_ai_player_move) if @ttt.is_current_player_ai? && !@ttt.game_over?
  end

  def play_move(move)
    ttt.play_move(move)
  end

  def board_images
    @img = []
    @ttt.get_board.each.with_index do |val, i|
      case val
      when :X
        @img[i] = "X.png"
      when :O
        @img[i] = "O.png"
      else
        @img[i] = "number#{i+1}.png"
      end
    end
    @img
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
