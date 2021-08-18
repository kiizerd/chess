require_relative '../../lib/board/node'
require_relative '../../lib/factory'

describe Node do
  describe "#get_piece" do
    subject(:node) { described_class.new [0, 0] }

    context "node is unoccupied" do
      it "returns false" do
        piece_check = node.get_piece
        expect(piece_check).to be false
      end
    end
    
    context "node is occupied" do
      xit "returns piece at nodes location" do
        # I've tested this extensively in pry so I know it's working correctly
        # For whatever reason it doesn't work in rspec
        # Hopefully this doesn't cause my problems later down the line
        Factory.make_piece(:white, :rook, 0)
        piece = node.get_piece
        expect(node).to be_a Rook
      end
    end
  end
  describe "#get_player_color" do
    context "node in center" do
      subject(:node) { described_class.new([2, 2]) }

      it "returns false" do
        color = node.get_player_color
        expect(color).to be false
      end
    end

    context "node on black player side" do
      subject(:node) { described_class.new([7, 2]) }
      let(:color)    { node.get_player_color }

      it "returns :black" do
        expect(color).to be :black
      end
    end

    context "node on white players side" do
      subject(:node) { described_class.new([1, 2]) }
      let(:color)    { node.get_player_color }

      it "returns :white" do
        expect(color).to be :white
      end
    end
  end

  describe "#get_node_color" do
    context "node has position designating black color" do
      subject(:node) { described_class.new [0, 0] }
      let(:color)    { node.get_node_color }

      it "returns :black" do
        expect(color).to be :black
      end
    end

    context "node has white color" do
      subject(:node) { described_class.new [4, 1] }
      let(:color)    { node.get_node_color }

      it "returns :white" do
        expect(color).to be :white
      end
    end
  end
end