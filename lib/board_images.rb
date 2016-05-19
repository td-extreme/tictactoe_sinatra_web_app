class BoardImages
  def self.get_images(board)
    images = []
    board.each.with_index do |val, i|
      case val
      when :X
        images[i] = "X.png"
      when :O
        images[i] = "O.png"
      else
        images[i] = "number#{i+1}.png"
      end
    end
    images
  end
end
