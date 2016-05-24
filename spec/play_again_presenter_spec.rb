require 'spec_helper'

describe PlayAgainPresenter do
  let (:game) { double }
  let (:presenter) { PlayAgainPresenter.new(game) }
  let (:board) { [' ', ' ', :X, ' ', ' ', :O, ' ', ' ', ' '] }

  it "creates an images array of size 9" do
    expect(game).to receive(:get_board).and_return(board)
    expect(presenter.images.size).to eq(9)
  end

  it "results = 'Tied Game!' when game is tied" do
    expect(game).to receive(:tied_game?).and_return(true)
    expect(presenter.results).to eq("Tied Game!")
  end

  it "results = 'Player X is the Winner!' when X is the winner" do
    expect(game).to receive(:tied_game?).and_return(false)
    expect(game).to receive(:winner).and_return(:X)
    expect(presenter.results).to eq("Player X is the Winner!")
  end

  it "results = 'Player O is the Winner!' when X is the winner" do
    expect(game).to receive(:tied_game?).and_return(false)
    expect(game).to receive(:winner).and_return(:O)
    expect(presenter.results).to eq("Player O is the Winner!")
  end
end
