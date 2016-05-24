require 'game_view_selector'

describe GameViewSelector do
  let(:game) { double }
  let(:move_played_valid) { true }
  let(:move_played_invalid) { false }
  let(:test_board) { [' ', ' ', ' ', :X, :O, :X, ' ', ' ', ' '] }

  it "creates a board images array" do
    expect(game).to receive(:get_board).and_return(test_board)
    allow(game).to receive(:game_over?).and_return(false)
    selector = GameViewSelector.new(game, move_played_valid) 
    expect(selector.presenter.images.size).to eq(9)       
  end

  it "chooses play_move for the view when game is not over" do
    expect(game).to receive(:get_board).and_return(test_board)
    allow(game).to receive(:game_over?).and_return(false)
    selector = GameViewSelector.new(game, move_played_valid)
    expect(selector.view).to be(:play_move)
  end

  it "chooses play_again for the view when game is over" do
    expect(game).to receive(:get_board).and_return(test_board)
    allow(game).to receive(:game_over?).and_return(true)
    selector = GameViewSelector.new(game, move_played_valid)
    expect(selector.view).to be(:play_again)
  end

  it "chooses play_move_pesenter when the game is not over" do
    expect(game).to receive(:get_board).and_return(test_board)
    allow(game).to receive(:game_over?).and_return(false)
    selector = GameViewSelector.new(game, move_played_valid)
    expect(selector.presenter.class).to be(PlayMovePresenter)
  end
  it "chooses play_again_presenter when the game is over" do
    expect(game).to receive(:get_board).and_return(test_board)
    allow(game).to receive(:game_over?).and_return(true)
    selector = GameViewSelector.new(game, move_played_valid)
    expect(selector.presenter.class).to be(PlayAgainPresenter)
  end
 
end
