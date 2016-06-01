require './lib/game'
require 'ai_basic'
require 'ai_minimax'
require 'game_rules'
require 'game_board'

class GameSetup

  attr_accessor :game
  def initialize(order, opponent)
    rules = GameRules.new
    board = GameBoard.new
    ai_player = setup_opponent(opponent, rules)
    @game = Game.new(rules, board, ai_player, order)
  end

  def setup_opponent(opponent, rules)
    if opponent == "easy"
        AiBasic.new(rules)
    elsif opponent == "hard"
        AiMinimax.new(rules)
    else
        :human
    end
  end
end 
