class PlayAgainPresenter

  attr_accessor :images

  def initialize(game)
    @game = game
  end

  def results
    @game.tied_game? ? "Tied Game!" : "Player #{@game.winner} is the Winner!"
  end
end
