require './lib/board_images'

class PlayAgainPresenter

  def initialize(game)
    @game = game
  end

  def images
    BoardImages.new(@game.get_board).images
  end

  def results
    @game.tied_game? ? "Tied Game!" : "Player #{@game.winner} is the Winner!"
  end
end
