classes:

EventBus - DONE
  publish
  subscribe

Event - DONE
  fire
  
EventHandler - DONE
  wrapper for a proc
  token for guarunteed uniqueness


Factory
  generates players pieces - DONE


GameState


GameBoard
  pieces - DONE
  board/graph - Might be unneccesary
    indexed rows [0..7]
    indexed cols [0..7]
    keyed rows [a..e]
    keyed cols [1..8]
  generates nodes - DONE
    nodes - DONE
      color
      row
      col
      occupied?
      piece


Game
  include Display
  input - DONE
  handle_move(player)
    handle_human_move if player is human
  handle_human_move
    show board and list pieces with valid moves
    get player piece selection
    list pieces valid moves
  main_loop
    each player turn
      Display::show movable pieces
      Display::show(on board) last move by self
      Display::show(on board) last move by other player
      Display::when piece selected
                show possible moves
                show possible moves that would be attacks
      handle_move
    update_display
    is_game_over?


Player
  include MoveValidator
  color
  name
  number
  stats
  pieces
    key for each piece pawn1, pawn2, king, queen, etc...
    key for list of alive pieces [:active]
    key for list of dead pieace  [:inactive]


GamePiece
  include Pathfinder
  possible_moves
  current_pos
  last_pos
  last_move


Knight < GamePiece

Pawn < GamePiece

Bishop < GamePiece

Rook < GamePiece

King < GamePiece

Queen < GamePiece




modules:

Display

Pathfinder

MoveValidator
