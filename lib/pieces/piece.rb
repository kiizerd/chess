class Piece

  attr_reader :color

  def initialize color, pos
    @color = color.to_sym
    @position = {
      current:  [pos[0], pos[1]],
      previous: nil
    }
    
    @last_move = [@position[:prev], @position[:current]]
  end

  # shorthand for current position
  def pos
    @position[:current]
  end

  def prev
    @position[:previous]
  end

  def set_position new_pos
    @position[:current] = new_pos
  end

  def set_last_move arr
    @last_move = arr
  end

  def update_position new_pos
    @last_move = [pos(), new_pos]
    @position[:previous] = pos()
    set_position new_pos
  end
  
  def remove_from_board
    @position[:prev] = @position[:current]
    @position[:current] = nil
    @captured = true
  end

  # a move will be defined as a pair of a positions, which in turn are a pair of coordinates
  # an origin and a destination
  def get_valid_moves
    possible_moves.select { |dir, mov| check_bounds(mov[0], mov[1]) }
  end

  # up is defined as the black home side of the board, rank 8, row 7
  # down is the white home side, rank 1, row 0
  # left and right can be deduced
  # the parent class has moves matching the King piece
  # every other piece will define it's own moves
  def possible_moves
    rank, file = pos
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
    (rank <= 7 && 0 <= rank) && (file <= 7 && 0 <= file) ? true : false
  end
end