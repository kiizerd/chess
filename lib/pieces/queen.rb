class Queen < Piece
  def initialize color, pos
    super
    @distance = 8 
  end

  def move_directions
    [
      :up, :down, :left, :right,
      :down_left, :down_right,
      :up_left, :up_right
    ]
  end
end