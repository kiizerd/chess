require_relative '../../lib/event_bus/event_bus'

describe EventBus do
  subject(:event_bus) { described_class.new }

  describe "#get_event" do
    context "given token matches existing event" do
      let(:new_event) { Event.new :new_event }
      before { event_bus.events << new_event }

      it "returns event object" do
        event = event_bus.get_event :new_event
        expect(event).to be_an Event
      end
    end

    context "given non-matching token" do
      let(:event) { event_bus.get_event :nonexistant }
      it "returns false" do
        expect(event).to be false
      end
    end
  end

  describe "#subscribe" do
    let(:handler)   { Handler.new(:handler, ->{ p :hi })  }

    context "subscribing to a non-existant event" do
      it "creates a new event with given name" do
        event_bus.subscribe :new_event, handler
        event_name = event_bus.events[-1].name
        expect(event_name).to be :new_event
      end

      it "subscribes(adds given handler) to new event" do
        event_bus.subscribe :new_event, handler
        event_handler = event_bus.get_event(:new_event).handlers[0]
        expect(event_handler).to be handler
      end
    end

    context "subscribing to existing event" do
      before { event_bus.events[0] = Event.new :old_event }
      it "subscribes to event" do
        event_bus.subscribe(:old_event, handler)
        expect(event_bus
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
        event_bus.publish(:new_event, { hi: 'there' })
        event = event_bus.get_event :new_event
        expect(event).to be_an Event
      end
    end

    context "publishing existing event" do
      let(:event) { Event.new :super_special_event }
      let(:handler) { Handler.new :super_handler, ->{ p x} }
      before { event.handlers << handler }
      before { event_bus.events << event }

      it "calls all of events handlers" do
        expect(handler).to receive(:call).with({ hi: "there" })
        event_bus.publish(:super_special_event, { hi: "there" })
      end
    end
  end
end