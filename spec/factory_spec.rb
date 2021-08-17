require_relative '../lib/factory'

describe Factory do
  describe "#make_all_pieces" do
    let(:pieces) { Factory.make_all_pieces }

    xit "fills the counts hash with non-zero values" do
      expect(Factory.counts[:white]).to all( be_between(1, 8) )
      expect(Factory.counts[:black]).to all( be_between(1, 8) )
    end

    xit "returns a hash" do
      expect(pieces).to be_a Hash
    end

    xit "has keys for white, black, active and inactive" do
      expect(pieces).to include(
        :black,
        :white
      )
    end
  end

  describe "#make_piece" do
    let(:piece) { Factory.make_piece(:black, :king) }

    it "returns a piece" do
      expect(piece).to be_a Piece
    end

    it "returns piece of correct color" do
      expect(piece.color).to be :black
    end

    it "returns correct piece" do
      expect(piece).to be_a King
    end
  end

  describe "#make_typed_piece" do
    let(:pawn) { Factory.make_typed_piece(:black, :pawn) }
    let(:king) { Factory.make_typed_piece(:white, :king) }

    it "returns given type as Class" do
      expect(pawn).to be_a Pawn
    end

    it "returns piece with correct color" do
      expect(pawn.color).to be :black
    end

    it "returns piece with correct position" do
      expect(king.pos).to eq [0, 4]
    end
  end

  describe "#make_board_graph" do
    
  end

  describe "#make_board_node" do
    
  end
end