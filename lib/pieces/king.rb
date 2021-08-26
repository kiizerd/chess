class King < Piece
  def initialize color, pos
    super
  end
  
  def move_directions
    [
      :up, :down, :left, :right,
      :down_left, :down_right,
      :up_left, :up_right
    ]
  end

  def remove_from_board
    super
    EventBus.publish(:king_killed, {
      king: self
    })
  end
end