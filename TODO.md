Classes:
  EventBus - remove_event_handler
  Event - remove event_handlers, instead collect subscriber at event subscribe time to determine uniqueness -- i think this will be better

  GameBoard - add diagonal handling to get_nodes_between
            - add method to check is moving piece is a pawn
                and if so only allow moves if dest node is unoccupied and only allow capture moves if en_passant or target is diagonal

  Player

  GamePiece
    Pawn
    Bishop
    Rook
    Knight
    King
    Queen

Modules:
  Display

  Pathfinder

  MoveValidator