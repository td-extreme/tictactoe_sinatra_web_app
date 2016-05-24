require 'spec_helper'

describe PlayMovePresenter do
  let (:game) { double }
  let (:played_move) { double }
  let (:board) { [' ', ' ', :X, ' ', ' ', :O, ' ', ' ', :X] }

  it "creates an images array of size 9" do
    presenter = PlayMovePresenter.new(game, false)
    expect(game).to receive(:get_board).and_return(board)
    expect(presenter.images.size).to eq(9)
  end

  it "message is 'That is not a valid move!' when played_move is false" do
    presenter = PlayMovePresenter.new(game, false)
    expect(presenter.message).to eq("That is not a valid move!")
  end

  it "message is nil when played_move is true" do
    presenter = PlayMovePresenter.new(game, true)
    expect(presenter.message).to eq(nil)
  end
end
