require_relative 'node'

class Board

  attr_reader :nodes, :last_move, :ranks, :files

  def initialize
    @ranks = (1..8).to_a
    @files = (:a..:h).to_a
    @last_move = {}
    @nodes = make_nodes
  end

  # TODO - move this to Factory and listen for it here
  def make_nodes
    nodes = {}
    @files.each_with_index do |file, ind|
      @ranks.each do |rank|
        symbol = "#{file}#{rank}".to_sym
        nodes[symbol] = Node.new([rank - 1, ind])
      end
    end
    nodes
  end

  def pieces
    @nodes
      .values
      .select { |n| n.occupied? }
      .map    { |n| n.piece }
      .each   { |p| yield p if block_given? }
  end

  def get_king player_color
    pieces.select { |p| p.color == player_color && p.class == King }[0]
  end

  # applies move to stubbed board and checks if king would be in check from move
  def check_move? piece, origin, dest
    real_nodes = stub_nodes

    apply_move(piece, origin, dest)
    dest_node = node_at(dest)
    check = king_in_check?(piece.color)
    @nodes = real_nodes
    return check
  end

  # Applies move to piece without checking gamerules or move validity
  def apply_move piece, origin, dest
    node_at(origin).remove_piece

    dest_node = node_at(dest)
    dest_node.piece_captured_by(piece) if dest_node.occupied?
    dest_node.update_piece piece
    @last_move = { piece: piece, origin: origin, dest: dest }
  end

  def check_pawn_move pawn, origin, dest
    is_capture_move = origin[1] != dest[1]
    dest_occupied = node_at(dest).occupied?
    return false if is_capture_move && !can_en_passant?(pawn) && !dest_occupied
    return false if is_capture_move && !dest_occupied 
    return false if !is_capture_move && dest_occupied
    return true
  end

  def can_en_passant? attacker
    return false unless attacker.is_a? Pawn
    return false unless last_move[:piece].is_a? Pawn
    return false unless attacker.color != last_move[:piece].color
    return false unless last_move_pawn_double?
    return false unless attacker_was_passed? attacker
    return true
  end

  def last_move_pawn_double?
    return false unless last_move[:piece].is_a? Pawn
    org  = last_move[:origin][0]
    dest = last_move[:dest][0]
    return true if (org - dest == 2) || (dest - org == 2)
    return false
  end

  def attacker_was_passed? attacker
    atk_rank, atk_file = attacker.pos
    tgt_rank, tgt_file = last_move[:piece].pos
    same_rank = tgt_rank == atk_rank
    diff_file = (tgt_file == atk_file + 1) || (tgt_file == atk_file - 1) 
    return true if same_rank && diff_file
    return false
  end

  def can_castle? king_piece, rook_piece
    return false unless king_piece.prev.nil?
    return false unless rook_piece.prev.nil?
    king_node, rook_node = node_at(king_piece.pos), node_at(rook_piece.pos)
    return false unless nodes_between_clear?(king_node, rook_node)
    color = king_piece.color
    return false unless nodes_between_safe?(king_node, rook_node, color)
    return true
  end

  def nodes_between_clear? node_a, node_b
    get_nodes_between(node_a, node_b).none? { |n| n.occupied? }
  end

  def nodes_between_safe? node_a, node_b, safe_color
    nodes = get_nodes_between(node_a, node_b)
    nodes.all? { |n| node_safe?(n, safe_color) }
  end

  def node_safe? node, safe_color
    pieces
      .reject { |p| p.color == safe_color }
      .select { |p| p.get_valid_moves.values.include? node.pos }
      .empty?
  end

  def king_in_check? player_color
    king = get_king(player_color)
    king_node = node_at king.pos
    # inverted for clarity; king in check when node not safe
    return node_safe?(king_node, player_color) ? false : true
  end

  def king_in_checkmate? player_color
    return false unless king_in_check?(player_color)
    possibles = get_king(player_color).get_valid_moves
    return possibles.any? { |poss| node_safe?(node_at(poss)) }
  end

  def clone_nodes
    Marshal.load(Marshal.dump(@nodes))
  end

  def stub_nodes
    fake_nodes = clone_nodes
    real_nodes = @nodes
    @nodes = fake_nodes
    return real_nodes
  end

  def get_node_key row, col
    "#{@files[col]}#{@ranks[row]}".to_sym
  end

  def node_at arr
    row, col = arr
    @nodes[get_node_key(row, col)]
  end

  def get_nodes_between node_a, node_b
    case
    when node_a.file == node_b.file
      get_nodes_between_rank(node_a, node_b)
    when node_a.rank == node_b.rank
      get_nodes_between_file(node_a, node_b)
    when (node_a.rank - node_b.rank).abs == (node_a.file - node_b.file).abs
      get_nodes_between_diag(node_a, node_b)
    else
      false
    end
  end

  def get_nodes_between_rank node_a, node_b
    positions = [node_a.pos[0], node_b.pos[0]]
    ranks = (positions.min..positions.max).to_a[1..-2]
    file = node_a.pos[1]
    ranks.reduce([]) do |nodes, rank|
      nodes << node_at([rank, file])
      nodes
    end
  end

  def get_nodes_between_file node_a, node_b
    positions = [node_a.pos[1], node_b.pos[1]]
    files = (positions.min..positions.max).to_a[1..-2]
    rank = node_a.pos[0]
    files.reduce([]) do |nodes, file|
      nodes << node_at([rank, file])
      nodes
    end
  end

  def get_nodes_between_diag node_a, node_b
    horz = node_a.file < node_b.file ? :right : :left
    vert = node_a.rank < node_b.rank ? :up    : :down
    dist = (node_a.rank - node_b.rank).abs - 1
    (1..dist).to_a.reduce([]) do |nodes, i|
      nodes << node_at([
        node_a.rank + (vert == :up ? i : -i),
        node_a.file + (horz == :right ? i : -i)
      ])
    end
  end

end
