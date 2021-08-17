require_relative 'pieces/pieces'
require_relative 'event_bus/event_bus'

# TODO - extract groupable methods into modules
# PieceFactory NodeFactory
class Factory

  @@counts =  {
    white: {
      pawn: 0,
      bishop: 0,
      knight: 0,
      rook: 0,
      king: 0,
      queen: 0
    },
    black: {
      pawn: 0,
      bishop: 0,
      knight: 0,
      rook: 0,
      king: 0,
      queen: 0
    }
  }

  def self.make_piece(color, type)
    piece   = make_typed_piece(color, type)
    payload = { piece: piece, color: color }
    EventBus.publish(:piece_made, payload) # listen for this event at player and at node
    piece
  end

  def self.make_typed_piece(color, type)
    case type
    when :pawn   then make_pawn(color)
    when :bishop then make_bishop(color)
    when :knight then make_knight(color)
    when :rook   then make_rook(color)
    when :queen  then make_queen(color)
    when :king   then make_king(color)
    end
  end

  def self.make_pawn color
    count = counts[color][:pawn]
    return if count == 8
    rank = color == :black ? 6 : 1
    file = count
    Pawn.new(color, [rank, file])
  end

  def self.make_bishop color
    count = counts[color][:bishop]
    return if count == 2
    rank = color == :black ? 7 : 0
    file = count == 0   ? 2 : 5
    Bishop.new(color, [rank, file])
  end

  def self.make_knight color
    count = counts[color][:knight]
    return if count == 2
    rank = color == :black ? 7 : 0
    file = count == 0      ? 1 : 6
    Knight.new(color, [rank, file])
  end

  def self.make_rook color
    count = counts[color][:rook]
    return if count == 2
    rank = color == :black ? 7 : 0
    file = count == 0      ? 7 : 0
    Rook.new(color, [rank, file])
  end

  def self.make_queen color
    return if counts[color][:queen] == 1
    pos = color == :black ? [7, 3] : [0, 3]
    @@counts[color][:queen] += 1
    Queen.new color, pos
  end

  def self.make_king color
    return if counts[color][:king] == 1
    pos = color == :black ? [7, 4] : [0, 4]
    counts[color][:king] += 1
    King.new color, pos
  end

  def self.counts
    @@counts
  end
end