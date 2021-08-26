require_relative '../../lib/pieces/pieces'

describe Knight do
  describe "#get_valid_moves" do
    subject(:knight) { described_class.new(:white, [0, 1]) }
    let(:moves) { knight.get_valid_moves }
    before { board = Board.new }

    context "white knight alone on the board" do
      it "returns a hash" do
        expect(moves).to be_a Hash
      end

      it "has keys for up_left, up_right and right_up" do
        expect(moves.keys).to include(
          :up_left, :up_right, :right_up
        )
      end
    end

    context "black knight alone on the board" do
      subject(:knight) { described_class.new(:black, [7, 2]) }
      let(:moves) { knight.get_valid_moves }

      it "returns a hash" do
        expect(moves).to be_a Hash
      end

      it "has keys for down_left, down_right, and right_down" do
        expect(moves.keys).to include(
          :down_left, :down_right, :right_down
        )
      end
    end
  end
end