class Game
  def initialize

  end

  def user_input(min, max)
    loop do
      input = gets.chomp.to_i
      verified = verify_input(min, max, input)
      return verified if verified
    end
  end

  def verify_input(min, max, input)
    input >= min && input <= max ? input : false
  end
end