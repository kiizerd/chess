require_relative '../../lib/pieces/pieces'

describe Pawn do
  describe "#get_valid_moves" do
    subject(:pawn) { described_class.new(:black, [6, 1]) }
    let(:moves) { pawn.get_valid_moves }

    context "black pawn that hasn't moved" do
      it "returns a hash" do
        expect(moves).to be_a Hash
      end

      it "has keys for :down, :down_right, and :down_left" do
        expect(moves.keys).to include(
          :down, :down_left, :down_right
        )
      end

      it "has 2 moves in down direction" do
        expect(moves[:down].size).to be 2
      end
    end

    context "white pawn that hasn't moved" do
      subject(:pawn) { described_class.new(:white, [1, 2]) }
      let(:moves) { pawn.get_valid_moves }
      
      it "returns a hash" do
        expect(moves).to be_a Hash
      end

      it "has keys for :up, :up_left, and :up_right" do
        expect(moves.keys).to include(
          :up, :up_left, :up_right
        )
      end

      it "has 2 moves in up direction" do
        expect(moves[:up].size).to be 2
      end
    end
  end
end