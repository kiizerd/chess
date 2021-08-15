classes:

EventBus
  publish
  subscribe

Event
  fire
  
EventHandler < Proc

GameState

GameBoard
  pieces
  board/graph
    nodes
    indexed rows [0..7]
    indexed cols [0..7]
    keyed rows [a..e]
    keyed cols [1..8]

Game
  input
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
  color
  name
  number
  stats
  pieces
    key for each piece pawn1, pawn2, king, queen, etc...
    key for list of alive pieces [:active]
    key for list of dead pieace  [:inactive]

GamePiece
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
