require_relative 'pieces/pieces'
require_relative 'event_bus/event_bus'

# TODO - extract groupable methods into modules
# PieceFactory NodeFactory
class Factory

  def self.make_players
    (1..2).to_a.reduce([]) do |players, num|
      players << Player.new(num, [:black, :white][num-1])
      players
    end
  end

  @@amounts = { pawn: 8, bishop: 2, knight: 2, rook: 2, queen: 1, king: 1 }

  # TODO - make this prettier
  def self.make_all_pieces
    [:white, :black].reduce({}) do |pieces, color|
      pieces.merge(color => (@@amounts.map do |type, count|
        typed_pieces = case
        when type == :king  then make_piece(color, :king)
        when type == :queen then make_piece(color, :queen)
        else Array.new(count) { |i| make_piece(color, type, i) }
        end
        [type, typed_pieces]
      end.to_h))
    end
  end

  def self.make_piece(color, type, count=0)
    piece   = make_typed_piece(color, type, count)
    payload = { color: color, piece: piece, number: count }
    EventBus.publish(:piece_made, payload) # listen for this event at player and at node
    piece
  end

  def self.make_typed_piece(color, type, num=0)
    case
    when type == :pawn   then make_pawn(color, num)
    when type == :bishop then make_bishop(color, num)
    when type == :knight then make_knight(color, num)
    when type == :rook   then make_rook(color, num)
    when type == :queen  then make_queen(color)
    when type == :king   then make_king(color)
    end
  end

  def self.make_pawn color, num
    rank = color == :black ? 6 : 1
    file = num
    Pawn.new(color, [rank, file])
  end

  def self.make_bishop color, num
    rank = color == :black ? 7 : 0
    file = num   == 0   ? 2 : 5
    Bishop.new(color, [rank, file])
  end

  def self.make_knight color, num
    rank = color == :black ? 7 : 0
    file = num   == 0      ? 1 : 6
    Knight.new(color, [rank, file])
  end

  def self.make_rook color, num
    rank = color == :black ? 7 : 0
    file = num   == 0      ? 0 : 7
    Rook.new(color, [rank, file])
  end

  def self.make_queen color
    pos = color == :black ? [7, 3] : [0, 3]
    Queen.new color, pos
  end

  def self.make_king color
    pos = color == :black ? [7, 4] : [0, 4]
    King.new color, pos
  end
end