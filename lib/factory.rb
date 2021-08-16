require_relative 'pieces/pieces'
require_relative 'event_bus/event_bus'

class Factory
  def self.make_piece(color, type)
    piece = make_typed_piece(color, type)
    event_name = "piece_made_" + color.to_s + "_" + type.to_s 
    EventBus.publish(event_name, piece)
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

  end

  def self.make_bishop color

  end

  def self.make_knight color

  end

  def self.make_rook color

  end

  def self.make_queen color

  end

  def self.make_king color
    pos = color == :black ? [7, 4] : [0, 4]
    King.new color, pos
  end
end