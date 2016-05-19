require 'board_images'

describe BoardImages do

  let (:test_board) { [:X, :O, :X, ' ', ' ', ' ', :O, :X, :O] }
  describe "board_images" do
    it "returns an arrray of length 9" do
      expect(subject.get_images(test_board).length).to eq(9)
    end

    it "index 0 is 'X.png' when ttt.baord[0] = :X" do
      images = subject.get_images(test_board)
      expect(images[0]).to eq("X.png")
    end

    it "index 1 is 'O.png' when ttt.baord[1] = :O" do
      images = subject.get_images(test_board)
      expect(images[1]).to eq("O.png")
    end

    it "index 4 is 'number5.png' when ttt.baord[4] = ' '" do
      images = subject.get_images(test_board)
      expect(images[4]).to eq("number5.png")
    end
  end
end
