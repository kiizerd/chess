class Knight < Piece
  def initialize color, pos
    super
  end

  def move_directions
    [
      :up_left, :up_right,
      :left_up, :left_down,
      :right_up, :right_down,
      :down_left, :down_right
    ]
  end

  def possible_moves
    rank, file = pos
    {
      left_up:    get_moves_in_dir(:left_up),
      left_down:  get_moves_in_dir(:left_down),
      right_up:   get_moves_in_dir(:right_up),
      right_down: get_moves_in_dir(:right_down),
      up_left:    get_moves_in_dir(:up_left),
      up_right:   get_moves_in_dir(:up_right),
      down_left:  get_moves_in_dir(:down_left),
      down_right: get_moves_in_dir(:down_right)
    }
  end

  def get_moves_in_dir dir
    rank, file = pos
    moves = []
    case dir
    when :left_up    then moves << [rank + 1, file - 2]
    when :left_down  then moves << [rank - 1, file - 2]
    when :right_up   then moves << [rank + 1, file + 2]
    when :right_down then moves << [rank - 1, file + 2]
    when :up_left    then moves << [rank + 2, file - 1]
    when :up_right   then moves << [rank + 2, file + 1]
    when :down_left  then moves << [rank - 2, file - 1]
    when :down_right then moves << [rank - 2, file + 1]
    end
    moves
  end
end