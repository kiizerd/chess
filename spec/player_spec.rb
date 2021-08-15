require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new }
  describe "pieces" do
    let(:pieces) { player.pieces }

    it "returns a hash" do
      pieces = player.pieces
      expect(pieces).to be_a Hash
    end

    it "has active key for living pieces" do
      expect(pieces).to have_key(:active)
    end

    it "has inactive key for dead pieces" do
      expect(pieces).to have_key(:inactive)
    end
  end
end