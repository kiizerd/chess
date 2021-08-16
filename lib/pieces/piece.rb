class Piece

  attr_reader :color, :pos

  def initialize color, pos
    @color = color.to_sym
    @position = {
      rank: pos[0] + 1,
      file: pos[1] + 1,
      current: [pos[0] + 1, pos[1] + 1],
      prev:    nil
    }
    
    @last_move = [@position[:prev], @position[:current]]
  end

  def get_valid_moves
    moves.select { |dir, mov| check_bounds(mov[0], mov[1]) }
  end

  # up is defined as the black home side of the board, rank 8, row 7
  # down is the white home side, rank 1, row 0
  # left and right can be deduced
  def moves
    rank, file = @position.values_at(:rank, :file)
    {
      up:    [rank + 1, file],
      down:  [rank - 1, file],
      left:  [rank, file - 1],
      right: [rank, file + 1],
      up_left:    [rank + 1, file - 1],
      up_right:   [rank + 1, file + 1],
      down_left:  [rank - 1, file - 1],
      down_right: [rank - 1, file + 1]
    }
  end

  def check_bounds rank, file
    (rank <= 8 && 1 <= rank) && (file <= 8 && 1 <= file) ? true : false
  end
end