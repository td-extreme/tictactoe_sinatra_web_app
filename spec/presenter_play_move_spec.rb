require 'presenter_play_move'

describe PresenterPlayMove do
  let (:game) { double }
  let (:played_move) { double }

  it "message is 'That is not a valid move!' when played_move is false" do
    presenter = PresenterPlayMove.new(false)
    expect(presenter.message).to eq("That is not a valid move!")
  end

  it "message is nil when played_move is true" do
    presenter = PresenterPlayMove.new(true)
    expect(presenter.message).to eq(nil)
  end
end
