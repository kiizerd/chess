require_relative 'node'
require 'pry'

class Board
  @@ranks = (:a..:h).to_a
  @@files = (1..8).to_a

  @@last_move = {}

  def self.make_nodes
    nodes = {}
    @@ranks.each_with_index do |rank, ind|
      @@files.each do |file|
        symbol = "#{rank}#{file}".to_sym
        nodes[symbol] = Node.new([ind, file - 1])
      end
    end
    nodes
  end

  @@nodes = make_nodes

  # Applies move to piece without checking gamerules or move validity
  def self.apply_move piece, origin, dest
    origin_node = @@nodes[(get_node_key(origin[0], origin[1]))]
    origin_node.remove_piece

    dest_node = @@nodes[get_node_key(dest[0], dest[1])]
    dest_node.piece_captured(piece) if dest_node.occupied?
    dest_node.set_piece piece
    @@last_move = { piece: piece, origin: origin, dest: dest }
  end

  def self.last_move
    @@last_move
  end

  def self.can_en_passant? attacker
    return false unless attacker.is_a? Pawn
    return false unless last_move[:piece].is_a? Pawn
    return false unless attacker.color != last_move[:piece].color
    return false unless last_move_pawn_double?
    return false unless attacker_was_passed? attacker
    return true
  end

  def self.last_move_pawn_double?
    return false unless last_move[:piece].is_a? Pawn
    org  = last_move[:origin][0]
    dest = last_move[:dest][0]
    return true if (org - dest == 2) || (dest - org == 2)
    return false
  end

  def self.attacker_was_passed? attacker
    atk_rank, atk_file = attacker.pos
    tgt_rank, tgt_file = last_move[:piece].pos
    same_rank = tgt_rank == atk_rank
    diff_file = (tgt_file == atk_file + 1) || (tgt_file == atk_file - 1) 
    return true if same_rank && diff_file
    return false
  end

  def can_castle? king_piece, rook_piece

  end

  def whatif_move?

  end

  def king_in_check? player

  end

  def king_in_checkmate? player

  end

  def check_move
    # temporarily applies the move to determine if executing
    # said move will result in a players own king in check
    # their opponents king in check, or if any enemy piece is
    # occupying the players selected pieces destination node
  end

  def self.get_node_key row, col
    "#{@@ranks[row]}#{@@files[col]}".to_sym
  end

  def self.node_at arr
    row, col = arr
    @@nodes[get_node_key(row, col)]
  end
end