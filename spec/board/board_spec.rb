require_relative '../../lib/board/board'
require_relative '../../lib/factory'

describe Board do
  describe "#make_nodes" do
    let(:nodes) { Board.make_nodes }  

    it "returns an hash" do
      expect(nodes).to be_a Hash
    end

    it "has keys for ranks and file i.e. a1, d5" do
      expect(nodes).to include(
        :a1, :b2, :c3, :d4, :e5, :f6, :g7, :h8
      )
    end

    it "has 64 values" do
      expect(nodes.size).to be 64
    end
  end
  
  describe "#apply_move" do
    
    context "piece moving to unoccupied node" do
      let(:piece) { Factory.make_piece(:black, :king) }

      it "moves piece" do
        Board.apply_move(piece, piece.pos, [6, 4])
        expect(piece.pos).to eq [6, 4]
      end

      it "updates last move class var" do
        initial_pos = piece.pos
        dest_pos    = [6, 4]
        Board.apply_move(piece, initial_pos, dest_pos)
        expect(Board.last_move).to include(
          piece: piece,
          origin: initial_pos,
          dest: dest_pos
        )
      end
    end

    context "piece moving to occupied node" do
      let(:attacker) { Factory.make_piece(:white, :king) }
      let(:captured) { Factory.make_piece(:black, :pawn) }

      before do
        Board.node_at([1, 3]).set_piece captured
        Board.apply_move(attacker, attacker.pos, captured.pos)
      end

      it "moves attacker" do
        expect(attacker.pos).to eq [1, 3]
      end

      it "captures occupying piece" do
        expect(captured.pos).to be nil
      end
    end
  end

  describe "#can_en_passant?" do
    context "given pawn can en passant" do
      
      let(:attacking_pawn) { Factory.make_piece(:white, :pawn) }
      let(:captured_pawn)  { Factory.make_piece(:black, :pawn) }
      
      before do
        atk_origin = attacking_pawn.pos
        cpt_origin = captured_pawn.pos
        Board.apply_move(attacking_pawn, atk_origin, [4, 0])
        Board.apply_move(captured_pawn, cpt_origin, [4, 1])
      end
      
      it "returns true" do
        en_passant = Board.can_en_passant? attacking_pawn
        expect(en_passant).to be true
      end
    end

    context "given pawn that cannot en passant" do
      let(:piece)  { Factory.make_piece(:white, :pawn) }
      let(:knight) { Factory.make_piece(:black, :knight) }

      before { Board.apply_move(knight, knight.pos, [5, 0]) }

      it "returns false" do
        en_passant = Board.can_en_passant? piece
        expect(en_passant).to be false
      end
    end

    context "given piece that isn't a pawn" do
      let(:piece) { Factory.make_piece(:white, :knight) }

      it "returns false" do
        check = Board.can_en_passant? piece
        expect(check).to be false  
      end
    end
  end

  describe "#can_castle?" do
    context "given king rook pair that can castle" do
      xit "returns true" do
        
      end
    end

    context "given king rook pair that cannot castle" do
      xit "returns false" do
        
      end
    end
  end

  describe "#whatif_move?" do
    
  end

  describe "#king_in_check?" do
    
  end

  describe "#king_in_checkmate?" do
    
  end
end