require_relative '../lib/factory'

describe Factory do
  describe "#make_all_pieces" do
    let(:pieces) { Factory.make_all_pieces }

    it "returns a hash" do
      expect(pieces).to be_a Hash
    end

    it "has hash value for white, black keys" do
      expect(pieces).to include(
        black: Hash,
        white: Hash
      )
    end

    it "each array has correct size" do
      sizes = pieces.map do |color, colored_pieces|
        counts = colored_pieces.map do |type, typed_pieces|
          size = typed_pieces.is_a?(Array) ? typed_pieces.size : 1
          [type, size]
        end.to_h
        [color, counts]
      end.to_h

      expect(sizes).to eq({
        white: {
          pawn: 8, bishop: 2, knight: 2, rook: 2, king: 1, queen: 1
        },
        black: {
          pawn: 8, bishop: 2, knight: 2, rook: 2, king: 1, queen: 1
        }
      })
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
    context "creating black pawn" do
      let(:pawn)   { Factory.make_typed_piece(:black, :pawn, 0) }

      it "returns given type as Class" do
        expect(pawn).to be_a Pawn
      end
      
      it "returns piece with correct color" do
        expect(pawn.color).to be :black
      end
    end
    
    context "creating white king" do
      let(:king)   { Factory.make_typed_piece(:white, :king) }

      it "returns a king" do
        expect(king).to be_a King  
      end
      
      it "returns piece with correct position" do
        expect(king.pos).to eq [0, 4]
      end
    end
    
    context "creating both black bishops" do
      let(:bishop) { Factory.make_typed_piece(:black, :bishop, 0) }
      let(:second_bishop) { Factory.make_typed_piece(:black, :bishop, 1) }

      it "returns a bishop" do
        expect(bishop).to be_a Bishop
      end

      it "returns a piece with correct position" do
        # returns 1st bishop
        expect(bishop.pos).to eq [7, 2]
      end

      it "returns correct piece on second call" do
        expect(second_bishop.pos).to eq [7, 5]
      end
    end
  end

  describe "#make_board_graph" do
    
  end

  describe "#make_board_node" do
    
  end
end