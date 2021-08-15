class Handler

  attr_reader :token

  def initialize token, proc
    @token = token
    @block = proc
  end

  def call args=nil
    case args
    when nil
      @block.call
    else
      @block.call args
    end
  end
end
