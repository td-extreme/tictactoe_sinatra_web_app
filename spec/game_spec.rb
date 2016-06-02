require 'game'

describe Game do
  let (:rules) { double }
  let (:test_board) { double }
  let (:opponent) { "ai_basic" }
  let (:order) { :p1 }
  let (:test_game) { Game.new(rules, test_board, opponent, order) }
  let (:test_game_human_vs_human) { Game.new(rules, test_board, :human, order) }

  describe 'play round' do
    it 'plays the ai turn after human turn if opponent is not human' do
      expect(test_game).to receive(:valid_move?).and_return(true)
      allow(test_game).to receive(:play_move)
      expect(test_game).to receive(:game_over?).and_return(false)
      expect(test_game).to receive(:play_ai_move)
      test_game.play_round(1)
    end

    it 'plays the ai turn after human turn if opponent is not human' do
      expect(test_game_human_vs_human).to receive(:valid_move?).and_return(true)
      allow(test_game_human_vs_human).to receive(:play_move)
      expect(test_game_human_vs_human).to receive(:game_over?).and_return(false)
      expect(test_game_human_vs_human).not_to receive(:play_ai_move)
      test_game_human_vs_human.play_round(1)
    end
  end 
end
