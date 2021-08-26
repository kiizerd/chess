require_relative 'player'
require_relative 'factory'
require_relative 'pieces/pieces'
require_relative 'board/board'

class Game
  def initialize
    @board = Board.new
    players
  end

  def main_loop
    # get current player

    # show players moveable pieces
    # get players pieces selection
    # get pieces potential moves
    # reject invalid moves

    # show selected pieces possible moves
    # get players selected pieces desired move 
    # or allow player to reselect

    # apply move

    # set next player as current player
  end

  def players() @players ||= [] end
  def colors() [:white, :black] end

  def fill_players
    if players.empty?
      2.times { |i| @players << create_player(i) }
    end
  end

  def create_player(num) Player.new(num + 1, colors[num]) end

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

  def is_game_over?
    players.each { |p| return true unless p.pieces[:king] }
    false
  end
end
