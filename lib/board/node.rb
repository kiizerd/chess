require 'pry'
require_relative '../event_bus/event_bus'

class Node

  attr_reader :color, :rank, :file, :piece

  def initialize pos
    @rank  = pos[0]
    @file  = pos[1]
    @color = get_node_color
    @occupied = false
    @piece    = nil
    
    EventBus.subscribe(:piece_made, listen_for_piece)
  end

  def pos
    [@rank, @file]
  end

  def listen_for_piece
    callback = ->(payload) do
      color = payload[:color]
      piece = payload[:piece]
      binding.pry
      if (color == get_player_color) && (piece.pos == pos)
        @occupied = true
        set_piece(piece)
      end
    end
    Handler.new(:node_piece_listener, callback)
  end

  def get_piece
    @piece ? @piece : false
  end

  def set_piece piece
    @piece = piece
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

end