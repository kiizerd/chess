require_relative 'validator'

class Player

  attr_reader :num, :color, :pieces

  def initialize(num, color)
    @num = num
    @color = color
    @pieces = []

    EventBus.subscribe(:piece_made, self, listen_for_piece)
  end

  def get_moveable_pieces board
    @pieces.select do |piece|
      get_piece_moves(piece, board).size > 0
    end
  end

  def get_piece_moves board, piece
    return get_pawn_piece_moves(piece, board) if piece.is_a? Pawn
    moves = piece.get_valid_moves
    moves.select do |dir, dir_moves|
      dir_moves.select do |dest|
        check_move_validity(board, piece, dest)
      end.size > 0
    end
  end

  def check_move_validity board, piece, move_dest
    orig_node = board.node_at(piece.pos)
    dest_node = board.node_at(move_dest)
    board_check = board.check_move?(piece, move_dest)
    color_check = dest_node.occupied? ? dest_node.piece.color != @color : true
    nodes_clear = board.nodes_between_clear?(orig_node, dest_node)
    path_check  = piece.is_a?(Knight) ? true : nodes_clear

    return (board_check && color_check && path_check)
  end

  def get_pawn_piece_moves pawn, board
    moves = pawn.get_valid_moves.select do |dir, dir_moves|
      dir_moves.select do |dest|
        pawn_check = board.check_pawn_move(pawn, dest)
        move_check = board.check_move?(pawn, dest)
        (pawn_check && move_check)
      end.size > 0
    end
  end

  def listen_for_piece
    callback = ->(payload) do
      color = payload[:color]
      piece = payload[:piece]
      if (color == @color)
        @pieces << piece
      end
    end
    Handler.new(:player_piece_listener, callback)
  end
end