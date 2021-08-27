class Pawn < Piece
  def initialize color, pos
    super
  end

  def move_directions
    case
    when @color == :white
      [:up, :up_left, :up_right]
    when @color == :black
      [:down, :down_right, :down_left]
    end
  end

  def get_moves_in_dir dir
    moves = []
    case @color
    when :white then moves = get_white_moves_in_dir(dir)
    when :black then moves = get_black_moves_in_dir(dir)
    end
  end

  def get_white_moves_in_dir dir
    rank, file = pos
    moves = []
    case dir
    when :up
      moves << [rank + 1, file]
      moves << [rank + 2, file] unless has_moved?
    when :up_left  then moves << [rank + 1, file - 1]
    when :up_right then moves << [rank + 1, file + 1]
    end
    moves
  end

  def get_black_moves_in_dir dir
    rank, file = pos
    moves = []
    case dir
    when :down
      moves << [rank - 1, file]
      moves << [rank - 2, file] unless has_moved?
    when :down_left  then moves << [rank - 1, file - 1]
    when :down_right then moves << [rank - 1, file + 1]
    end
    moves
  end
end