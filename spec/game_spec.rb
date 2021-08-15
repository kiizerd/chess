require_relative "../lib/game"

describe Game do
  subject(:game) { described_class.new }
  let(:p1)  { double('player', num: 1, color: :white) }
  let(:p2)  { double('player', num: 2, color: :black) }

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

  describe "#players" do
    context "no players created" do
      it "returns an empty array" do
        expect(game.players).to eq([])
      end
    end

    context "create_players called" do
      it "returns an array with 2 humans" do
        game.fill_players
        expect(game.players).to all( be_a(Player) )
      end
    end
  end

  describe "#create_player" do
    let(:num)    { 1 }
    let(:color)  { game.colors[num] }
    let(:player) { game.create_player num }

    it "returns a struct" do
      expect(player).to be_a Player
    end

    it "players num is +1 given number" do
      expect(player.num).to eq(num + 1)
    end

    it "has correct color" do
      expect(player.color).to eq(color)
    end
  end

  describe "is_game_over?" do
    context "both kings are alive and well" do
      it "returns false" do
        over = game.is_game_over?
        expect(over).to be false
      end
    end
    
    context "a king has been killed" do
      before do
        game.players[0] = p1
        allow(p1).to receive(:piece_killed)
        allow(p1).to receive(:pieces).and_return({king: false})
      end

      it "returns true" do
        over = game.is_game_over?
        expect(over).to be true
      end
    end
  end
end