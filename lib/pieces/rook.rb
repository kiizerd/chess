class Rook < Piece
  def initialize color, pos
    super
    @distance = 8
  end
  
  def move_directions
    [:up, :down, :left, :right]
  end
end