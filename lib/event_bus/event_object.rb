class Event

  attr_reader :name, :handlers

  def initialize name
    @name     = name
    @handlers = []
  end

  def has_handler? token
    @handlers.any? { |h| h.token == token }
  end

  def get_handler token
    return false unless has_handler? token
    return @handlers.find { |h| h.token == token }
  end

  def add_handler handler
    if has_handler? handler.token
      return false
    else
      @handlers << handler
    end
  end

  def remove_handler handler_token
    if has_handler? handler_token
      @handlers.delete get_handler handler_token
    else
      return false
    end
  end

  def fire event_args
    @handlers.each { |h| h.call event_args }
  end
end