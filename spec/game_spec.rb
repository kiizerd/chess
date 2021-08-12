require_relative "../lib/game"

describe Game do
  subject(:game) { described_class.new }

  describe "#user_input" do
    context 'given input within range' do
      before { allow(game).to receive(:gets).and_return "3" }
      it 'returns input' do
        input = game.user_input(1, 5)
        expect(input).to eq 3
      end
    end
  end

  describe "#verify_input" do
    context "given input within range" do
      it 'returns input' do
        input = game.verify_input(1, 5, 3)
        expect(input).to eq 3
      end
    end

    context "given input not within range" do
      it 'returns false' do
        input = game.verify_input(1, 5, 7)
        expect(input).to be false
      end
    end
  end
end