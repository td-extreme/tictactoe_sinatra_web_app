require './lib/play_again_presenter'
require './lib/play_move_presenter'
require './lib/board_images'

class GameViewSelector

  attr_reader :view, :presenter

  def initialize(game, move_played)
    @presenter = game.game_over? ? PlayAgainPresenter.new(game) : PlayMovePresenter.new(move_played)
    @presenter.images = BoardImages.new(game.get_board).images
    @view = game.game_over? ? (:play_again) : (:play_move) 
  end
end

