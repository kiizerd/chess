require_relative '../event_bus/event_bus'

class Node

  attr_reader :color, :rank, :file, :piece

  def initialize pos
    @rank  = pos[0]
    @file  = pos[1]
    @color = get_node_color
    @occupied = false
    @piece    = nil
    
    EventBus.subscribe(:piece_made, self, listen_for_piece(pos()))
  end

  def pos
    [@rank, @file]
  end

  def listen_for_piece node_pos
    callback = ->(payload) do
      color = payload[:color]
      piece = payload[:piece]
      if (color == get_player_color) && (piece.pos == node_pos)
        @occupied = true
        update_piece(piece)
      end
    end
    Handler.new(:node_piece_listener, callback)
  end

  def get_piece
    @piece ? @piece : false
  end

  def update_piece piece
    @occupied = true
    @piece    = piece
    @piece.update_position(pos()) if piece.pos != pos()
  end

  def remove_piece
    @piece    = nil
    @occupied = false
  end

  def piece_captured_by attacker
    payload = {
      attack_piece: attacker,
      captured_piece: @piece,
      node: self
    }
    # listen for this event on player
    EventBus.publish(:piece_captured, payload)

    @piece.remove_from_board
    remove_piece
  end

  def get_player_color
    case rank
    when 0..1 then return :white
    when 6..7 then return :black
    else return false
    end
  end

  def get_node_color
    (@rank + @file).even? ? :black : :white
  end

  def occupied?
    @occupied
  end

end