 ## Chess - The classic strategy game
 Brought to you in the terminal with Ruby.

 Final project for the Ruby Programming line of The Odin Project.
 

 ## Modules
  * Display
  * Pathfiner
  * MoveValidator
 
 ## Classes
  * GameClass:  
  * GameBoard:  
    Simulates the chess board, contains nodes which represent tiles of the board.
    Includes methods to check move validity, allow special moves, and check if a node or nodes is clear(occupied), or safe(not able to be attacked by an enemy piece on their next move).
  * Player:  
  * EventBus:  
    The EventBus class acts as a pipeline for events to help loosen object coupling.  
    An external object can either publish or subscribe to a new or existing event with an :event_name symbol.  
    Publishers call EventBus.publish(:event_name, payload), where payload is a hash containing data relevant to the event.  
    Subscribers call EventBus.subscribe(:event_name,    event_handler), where event_handler is a special object. 
  * Handler(EventHandler):  
    EventHandler objects have a proc or lambda @block and a symbol @token instance variables.  
    Block is to be called when then subscribed event is published.  
    Token is used to prevent multiple copies of identical handlers.
  * Event(EventObject):  
    Symbol named event that has an array of hashes, @handlers.  
    Each hash in @handlers has a subscriber and a handler key.  
    @handlers[n][:subscriber] will point to the object that subscribed to the event.  
    @handlers[n][:handler] points to the EventHandler object.(This should be reworked to just be a block and the EventHandler class can be done away with)  
    When event is published every handle is called with the payload sent by publisher as args.

