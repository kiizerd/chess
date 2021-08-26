require_relative '../../lib/pieces/pieces'

describe Bishop do
  subject(:bishop) { described_class.new :white, [1, 3] }

  describe "#get_valid_moves" do
    let(:moves) { bishop.get_valid_moves }

    it "returns a hash" do
      expect(moves).to be_a Hash  
    end

    it "has keys for diagonals" do
      expect(moves.keys).to include(
        :up_left, :up_right, :down_left, :down_right
      )
    end

    it "does NOT have keys or standard directions" do
      expect(moves).not_to include(
        :up, :right, :down, :left
      )
    end
  end

  describe "#get_moves_in_dir" do
    let(:moves) { bishop.get_moves_in_dir(:up_right) }

    it "returns an array" do
      expect(moves).to be_an Array
    end

    it "has a size of 8" do
      expect(moves.size).to be 8
    end

    it "includes tile to its up and right diagonal" do
      expect(moves).to include [2, 4]
    end
  end
end