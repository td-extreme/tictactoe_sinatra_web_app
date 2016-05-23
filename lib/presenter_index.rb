class PresenterIndex

  attr_accessor :player_order, :player_choices

  def initialize
    @player_order = PLAYER_ORDER
    @player_choices = PLAYER_CHOCIES
  end

  PLAYER_ORDER = {
    :p1 => 'Player',
    :p2 => 'Opponent',
  }

  PLAYER_CHOCIES = {
    :human => 'Human',
    :easy => 'Computer AI Easy',
    :hard => 'Computer AI Hard',
  }
end
