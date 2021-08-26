class Bishop < Piece
  def initialize color, pos
    super
    @distance = 8
  end

  def move_directions
    [:up_left, :up_right, :down_left, :down_right]
  end
end