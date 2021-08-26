class Piece

  attr_reader :color

  def initialize color, pos
    @distance = 1
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

  def has_moved?
    !prev.nil?
  end

  def update_position new_pos
    @last_move = [pos(), new_pos]
    @position[:previous] = pos()
    @position[:current] = new_pos
  end
  
  def remove_from_board
    @position[:prev] = @position[:current]
    @position[:current] = nil
    @captured = true
  end
  
  # a move here is defined as a symbol :dir, and an array
  # with the coordinates of the destination of move
  def get_valid_moves
    possible_moves.select do |dir, moves| 
      moves.select! { |mov| check_bounds(mov[0], mov[1]) }
      !moves.empty? && move_directions.include?(dir)
    end
  end

  def check_bounds rank, file
    (rank <= 7 && 0 <= rank) && (file <= 7 && 0 <= file) ? true : false
  end

  def move_directions
  # Typed pieces will use this method to reject moves
    []
  end

  # up is defined as the black home side of the board, rank 8, row 7
  # down is the white home side, rank 1, row 0
  # left and right can be deduced
  # the parent class has moves matching the King piece
  # every other piece will define it's own moves
  def possible_moves
    rank, file = pos
    {
      up:    get_moves_in_dir(:up),
      down:  get_moves_in_dir(:down),
      left:  get_moves_in_dir(:left),
      right: get_moves_in_dir(:right),
      up_left:    get_moves_in_dir(:up_left),
      up_right:   get_moves_in_dir(:up_right),
      down_left:  get_moves_in_dir(:down_left),
      down_right: get_moves_in_dir(:down_right)
    }
  end

  def get_moves_in_dir dir
    rank, file = pos
    (1..@distance).to_a.reduce([]) do |moves, i|
      case dir
      when :up    then moves << [rank + i, file]
      when :down  then moves << [rank - i, file]
      when :left  then moves << [rank, file - i]
      when :right then moves << [rank, file + i]
      when :up_left    then moves << [rank + i, file - i]
      when :up_right   then moves << [rank + i, file + i]
      when :down_left  then moves << [rank - i, file - i]
      when :down_right then moves << [rank - i, file + i]
      end
      moves
    end
  end
end