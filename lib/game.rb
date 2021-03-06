require_relative 'player'
require_relative 'factory'
require_relative 'pieces/pieces'
require_relative 'board/board'
require_relative 'display'

class Game

  include Display

  def initialize
    @board = Board.new
    @players = Factory.make_players
    Factory.make_all_pieces
    show_board(:white, @board)
  end

  def start
    
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
