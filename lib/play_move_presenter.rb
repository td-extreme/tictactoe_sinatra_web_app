require_relative './board_images'

class PlayMovePresenter

  def initialize(game, move_played = true)
    @game = game
    @move_played = move_played
  end

  def images
    BoardImages.new(@game.get_board).images
  end

  def message
    "That is not a valid move!" if !@move_played
  end
end
