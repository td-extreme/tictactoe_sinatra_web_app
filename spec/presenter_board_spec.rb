require 'presenter_board'

describe PresenterBoard do

  let (:test_board) { [:X, :O, :X, ' ', ' ', ' ', :O, :X, :O] }
  let (:test_presenter) { PresenterBoard.new(test_board) }
    it "returns an arrray of length 9" do
      expect(test_presenter.images.length).to eq(9)
    end

    it "index 0 is 'X.png' when ttt.board[0] = :X" do
      expect(test_presenter.images[0]).to eq("X.png")
    end

    it "index 1 is 'O.png' when ttt.board[1] = :O" do
      expect(test_presenter.images[1]).to eq("O.png")
    end

    it "index 4 is 'number5.png' when ttt.board[4] = ' '" do
      expect(test_presenter.images[4]).to eq("number5.png")
    end
  end
