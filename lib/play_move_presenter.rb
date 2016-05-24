class PlayMovePresenter

  attr_accessor :images

  def initialize(move_played = true)
    @move_played = move_played
  end

  def message
    "That is not a valid move!" if !@move_played
  end

end
