require 'game'

describe Game do

  let (:ttt) { double }
  let (:test_board) { [:X, :O, :X, ' ', ' ', ' ', :O, :X, :O] }

  describe "end_of_game" do
    it "returns 'Tied Game!' when the game is tied" do
      subject.instance_variable_set("@ttt", ttt)
      expect(ttt).to receive(:tied_game?).and_return(true)
      expect(subject.results).to eq("Tied Game!")
    end

    it "returns 'Player X is the Winner!' when X is the winner" do
      subject.instance_variable_set("@ttt", ttt)
      expect(ttt).to receive(:tied_game?).and_return(false)
      expect(ttt).to receive(:winner).and_return(:X)
      expect(subject.results).to eq("Player X is the Winner!")
    end
  end

  describe "play_ai_move" do
    it "Does NOT call play_move is the game is over" do
      subject.instance_variable_set("@ttt", ttt)
      expect(ttt).to receive(:game_over?).and_return(true)
      expect(ttt).to receive(:is_current_player_ai?).and_return(true)
      expect(ttt).not_to receive(:play_move)
      subject.play_ai_turn
    end

    it "Does NOT call play_move if the player is NOT Ai" do
      subject.instance_variable_set("@ttt", ttt)
      allow(ttt).to receive(:game_over?).and_return(true)
      expect(ttt).to receive(:is_current_player_ai?).and_return(false)
      expect(ttt).not_to receive(:play_move)
      subject.play_ai_turn
    end
 
    it "Does call play_move if the player is AI  and game is not over" do
      subject.instance_variable_set("@ttt", ttt)
      allow(ttt).to receive(:game_over?).and_return(false)
      expect(ttt).to receive(:is_current_player_ai?).and_return(true)
      expect(ttt).to receive(:play_move)
      expect(ttt).to receive(:get_ai_player_move)
      subject.play_ai_turn
    end
  end
end
