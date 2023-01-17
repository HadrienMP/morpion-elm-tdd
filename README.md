Tic Tac Toe
===========

Rules
-----
Basics
- there are __2 players__ in the game: __X and O__
- the grid is __3x3__
- X plays first
- players take turns taking fields until the game is over
- a player can take a field if not already taken

Ending
- a game is over when all fields are taken
- a game is over when all fields in a column are taken by a player
- a game is over when all fields in a row are taken by a player
- a game is over when all fields in a diagonal are taken by a player

Test examples
--------
### Take turns
```
Input :

|   |   |   |
|   | X |   |
|   |   |   |

Output : O is next
```
### X Wins on the diagonal
```
Input :

| O |   | X |
| O | X |   |
| X |   |   |

Output : X wins
```
### Draw
```
Input :

| O | X | O |
| X | X | O |
| X | O | X |

Output : Draw
```
