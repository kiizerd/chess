require_relative '../lib/factory'

describe Factory do
  describe "#make_all_pieces" do
    
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

  describe "#make_board_graph" do
    
  end

  describe "#make_board_node" do
    
  end
end