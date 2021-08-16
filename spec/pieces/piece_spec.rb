require_relative '../../lib/pieces/piece'

describe Piece do
  let(:pos)      { [0, 7] }
  subject(:piece) { described_class.new(:black, pos) }

  describe "#get_valid_moves" do
    context "piece in bottom_right of board" do
      let(:valid_moves) { piece.get_valid_moves}

      it "returns a hash" do
        expect(valid_moves).to be_a Hash
      end

      it "returned hash a size of 3" do
        expect(valid_moves.size).to be 3
      end

      it "returned hash has an up_left key" do
        expect(valid_moves).to have_key :up_left
      end
    end
  end
end