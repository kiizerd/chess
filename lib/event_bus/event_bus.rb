require_relative 'event_object'
require_relative 'event_handler'

require 'pry'

class EventBus

  attr_reader :events

  def initialize
    @events = []
  end

  def get_event name
    for event in @events do
      return event if event.name == name ||
                      event.name == name.to_sym
    end
    return false
  end

  def create_event name
    Event.new(name.to_sym)
  end

  def subscribe event_name, handler=nil
    event = get_event(event_name)
    if !event
      event = create_event(event_name)
      @events << event
    end
    event.add_handler handler
  end

  def publish event_name, *payload
    event = get_event(event_name)
    if !event
      event = create_event(event_name)
      @events << event
    end
    event.fire *payload
  end
end
