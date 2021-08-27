require 'paint'
require 'tty-prompt'

module Display

  def prompt
    TTY::Prompt.new
  end

  def introduction
    puts `clear`
    puts Paint[title, "gold", nil]
    puts Paint[welcome, :black, :white]
    main_menu
  end

  def main_menu
    options = ['Start Game', 'Configure', 'More Info', "Exit"]
    case prompt.select("Select an option:", options)
    when options[0] then start()
    when options[1] then configure_game
    when options[2] then puts additional_info
    when options[3] then system(exit)
    end
  end

  def player_selection
    options = ['Single Player', 'Two Players']
    case prompt.select("Select play mode:", options)
    when options[0] then start_game
    when options[1] then start_game 2
    end
  end

  def show_board orientation, board
    make_display_board(orientation, board).each do |row|
      case
      when row.class == Array then row.each { |node| print node }
      else print row
      end
    end
    print "\n"
  end
  
  def make_display_board orientation, board
    case
    when orientation == :white
      make_board_white_side(board)
    when orientation == :black
      make_board_black_side(board)
    end
  end

  def make_board_black_side board
    ranks, files = board.ranks, board.files
    display_board = []
    ranks.each_with_index do |rank, r_ind|
      node_row = []
      files.each_with_index do |file, f_ind|
        node_row << node_to_s(board.node_at([r_ind, f_ind]))
      end
      display_board << node_row
      display_board << "\n"
    end
    display_board
  end

  def make_board_white_side board
    make_board_black_side(board).reverse
  end

  def show_pieces pieces

  end

  def show_moves moves

  end

  def node_to_s node
    n_piece, n_color = node.piece, node.color
    tile_color = display_colors[:tiles][n_color.to_sym]
    piece_color = n_piece ? display_colors[:pieces][n_piece.color] : nil
    piece_string = n_piece ? ' ' + display_pieces[n_piece.class.to_s.downcase.to_sym] + ' ' : '   '

    Paint[piece_string, piece_color, tile_color]
  end

  def display_colors
    {
      tiles: {
        black: "#483626", white: "#d88858"
      },
      pieces: {
        black: "#506070", white: "#dadada"
      }
    }
  end

  def display_pieces
    {
      pawn: "\u265F".encode,
      rook: "\u265C".encode,
      king: "\u265A".encode,
      queen: "\u265B".encode,
      bishop: "\u265D".encode,
      knight: "\u265E".encode
    }
  end

  def title
    <<-TITLE

        ,o888888o.    8 8888        8 8 8888888888     d888888o.      d888888o.
       8888     `88.  8 8888        8 8 8888         .`8888:' `88.  .`8888:' `88.
    ,8 8888       `8. 8 8888        8 8 8888         8.`8888.   Y8  8.`8888.   Y8
    88 8888           8 8888        8 8 8888         `8.`8888.      `8.`8888.
    88 8888           8 8888        8 8 888888888888  `8.`8888.      `8.`8888.
    88 8888           8 8888        8 8 8888           `8.`8888.      `8.`8888.
    88 8888           8 8888888888888 8 8888            `8.`8888.      `8.`8888.
    `8 8888       .8' 8 8888        8 8 8888        8b   `8.`8888. 8b   `8.`8888.
       8888     ,88'  8 8888        8 8 8888        `8b.  ;8.`8888 `8b.  ;8.`8888
        `8888888P'    8 8888        8 8 888888888888 `Y8888P ,88P'  `Y8888P ,88P'
       
TITLE
  end

  def welcome
    <<-WELCOME.strip
|-----------------------------------------------------------------------------|
  Welcome to Chess, brought to the terminal by the Ruby programming language.  
|-----------------------------------------------------------------------------|
    WELCOME
  end

  def additional_info
    <<-INFORMATION
|-----------------------------------------------------------------------------|
  Chess is a recreational and competitive board game played with two players. 
  It is sometimes called Western or international chess to distinguish it 
  from related games such as xiangqi. 

  The current form of the game emerged in Southern Europe during the second
  half of the 15th century after evolving from similar, much older games of 
  Indian and Persian origin.

  Today, chess is one of the world's most popular games, played by millions 
  of people worldwide at home, in clubs, online, by correspondence, and in 
  tournaments.
|-----------------------------------------------------------------------------|
  Chess is an abstract strategy game and involves no hidden information. 
  It is played on a square chessboard with 64 squares arranged in an 
  eight-by-eight grid. 
  At the start, each player (one controlling the white pieces, the other 
  controlling the black pieces) controls sixteen pieces:
  one king, one queen, two rooks, two knights, two bishops, and eight pawns. 
  The object of the game is to checkmate the opponent's king, whereby
  the king is under immediate attack (in "check") and there is no way for it
  to escape. There are also several ways a game can end in a draw.
|-----------------------------------------------------------------------------|
    INFORMATION
  end
end