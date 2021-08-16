require_relative '../../lib/event_bus/event_bus'

describe EventBus do 
  describe "#get_event" do
    context "given token matches existing event" do
      let(:new_event) { Event.new :new_event }
      before { EventBus.events << new_event }

      it "returns event object" do
        event = EventBus.get_event :new_event
        expect(event).to be_an Event
      end
    end

    context "given non-matching token" do
      let(:event) { EventBus.get_event :nonexistant }
      it "returns false" do
        expect(event).to be false
      end
    end
  end

  describe "#subscribe" do
    let(:handler)   { Handler.new(:handler, ->{ p :hi })  }
    before { EventBus.subscribe :new_event, handler }

    context "subscribing to a non-existant event" do
      it "creates a new event with given name" do
        event_name = EventBus.events[-1].name
        expect(event_name).to be :new_event
      end

      it "subscribes(adds given handler) to new event" do
        new_handler = Handler.new :new_handler, ->{ p :hi_again }
        EventBus.subscribe :newer_event, new_handler
        event_handler = EventBus.get_event(:newer_event).handlers.first
        expect(event_handler).to be new_handler
      end
    end

    context "subscribing to existing event" do
      before { EventBus.events[0] = Event.new :old_event }
      it "subscribes to event" do
        EventBus.subscribe(:old_event, handler)
        expect(EventBus
                .get_event(:old_event)
                .handlers
                .find { |h| h == handler }
        ).to be handler
      end
    end
  end

  describe "#publish" do
    context "publishing nonexistant event" do
      it "creates a new event with given name" do
        EventBus.publish(:new_event, { hi: 'there' })
        event = EventBus.get_event :new_event
        expect(event).to be_an Event
      end
    end

    context "publishing existing event" do
      let(:event) { Event.new :super_special_event }
      let(:handler) { Handler.new :super_handler, ->{ p x} }
      before { event.handlers << handler }
      before { EventBus.events << event }

      it "calls all of events handlers" do
        expect(handler).to receive(:call).with({ hi: "there" })
        EventBus.publish(:super_special_event, { hi: "there" })
      end
    end
  end
end