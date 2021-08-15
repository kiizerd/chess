require_relative "../../lib/event_bus/event_object"
require_relative "../../lib/event_bus/event_handler"

describe Event do
  subject(:event)     { described_class.new :test_event }
  let(:handler_block) { ->(args) { args += 1 } }
  let(:handler)       { Handler.new :test_handler, handler_block }

  before { event.add_handler handler }

  describe "#has_handler?" do
    context "given a token that matches an included handler" do
      it "returns true" do
        check = event.has_handler? :test_handler
        expect(check).to be true
      end
    end

    context "given a unique, not included handler_token" do
      it "returns false" do
        check = event.has_handler? :random_bull
        expect(check).to be false
      end
    end
  end

  describe "#add_handler" do
    context "given a new unique hander object" do
      it "add the handler to the Events @handler array" do
        expect(event.handlers[0]).to eq handler
      end
    end

    context "given a handler with a registered token" do
      it "adds nothing anywhere and returns false" do
        expect(event.add_handler handler).to be false
      end
    end
  end

  describe "#remove_handler" do
    context "given a valid handler token" do
      it "removes the handler matching given token" do 
        event.remove_handler :test_handler
        expect(event.handlers.size).to eq 0
      end
    end

    context "given a non-matching token" do
      it "returns false" do
        check = event.remove_handler :nonexistant_handler
        expect(check).to be false 
      end

      it "removes nothing" do
        event.add_handler Handler.new :lmao, ->{ puts 'woohoo' }
        initial_size = event.handlers.size
        event.remove_handler :whoopidoda
        after_size = event.handlers.size

        expect(initial_size).to eq after_size
      end
    end
  end
  
  describe "#fire" do
    let(:proc)     { ->(payload) { puts payload } }
    let(:handler1) { Handler.new :handler1, proc }
    let(:handler2) { Handler.new :handler2, proc }

    before do
      event.remove_handler handler.token
      event.add_handler handler1
      event.add_handler handler2
    end

    it "calls each of its handlers with the args given" do
      str = 'testing'
      expect(handler1).to receive(:call).with str
      expect(handler2).to receive(:call).with str
      event.fire str
    end
  end
end