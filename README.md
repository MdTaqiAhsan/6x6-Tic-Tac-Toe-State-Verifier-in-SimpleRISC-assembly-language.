
## Tic-Tac-Toe State Verifier (SimpleRISC Assembly)

Designed and implemented a complete Tic-Tac-Toe state verification system in **SimpleRISC Assembly** for a generalized **6×6 game board**. The program analyzes a given game-state snapshot stored in memory, validates whether the state is legally reachable according to game rules, and determines the game outcome.

### Features

* Validates legality of any 6×6 Tic-Tac-Toe board state.
* Detects invalid game configurations and rule violations.
* Determines whether:

  * Player 1 has won,
  * Player 2 has won, or
  * The game ended in a draw.
* Handles edge cases involving move counts, winning conditions, and impossible board states.
* Produces a single deterministic output value for automated evaluation.

### Concepts Demonstrated

* Assembly programming with SimpleRISC
* Low-level algorithm design
* Memory management and addressing
* State validation and rule enforcement
* Exhaustive edge-case handling
* Control flow and branching logic

This project was developed as part of a computer architecture/assembly programming assignment to practice implementing complex game logic under low-level architectural constraints.
