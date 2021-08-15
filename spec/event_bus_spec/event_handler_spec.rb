require_relative '../../lib/event_bus/event_handler'

describe Handler do
  describe "#call" do
    it "calls its block" do
      proc = ->(args) { puts args }
      handler = Handler.new :test, proc

      expect(proc).to receive(:call).with 'testing'
      handler.call 'testing'
    end
  end
end