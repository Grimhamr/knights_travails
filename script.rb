require "./lib/moves"


d4_to_f2 = KnightMoves.new("d4","f2")
d4_to_f2.knight_moves #D4 -> E6 -> C5 -> D3 -> F2

a1_to_b3 = KnightMoves.new("a1","b3") #1 move
a1_to_b3.knight_moves

a8_to_f2 = KnightMoves.new("a8","f2")#5?
a8_to_f2.knight_moves

h4_to_f2 = KnightMoves.new("h4","f2")#4?
h4_to_f2.knight_moves
