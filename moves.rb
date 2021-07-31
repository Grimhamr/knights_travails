=begin
Your task is to build a function knight_moves that shows the simplest possible way to get from 
one square to another by outputting all squares the knight will stop on along the way.

You can think of the board as having 2-dimensional coordinates. Your function would therefore look like:

knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]
Put together a script that creates a game board and a knight.

Treat all possible moves the knight could make as children in a tree. Don’t allow any moves to go off the board.

Decide which search algorithm is best to use for this case. Hint: one of them could be a potentially infinite series.

Use the chosen search algorithm to find the shortest path between the starting square (or node) and the ending square. 

Output what that full path looks like, e.g.:
  > knight_moves([3,3],[4,3])
  => You made it in 3 moves!  Here's your path:
    [3,3]
    [4,5]
    [2,4]
    [4,3]
    
=end
def square_to_coordinates(square)
  square_coordinates=[]

  square_coordinates[0] = square[0].ord-64
  square_coordinates[1] = square[1].to_i
  
  square_coordinates

end

def coordinates_to_square(coordinates)

  square = "#{(coordinates[0]+64).chr}#{coordinates[1].to_s}" unless coordinates.nil?
  
  #puts "coordinates #{coordinates} correspond to square #{square}"

  square
end

def available_moves(current_square)
  #puts "Calculating available moves"
  available_moves = []

  available_moves[0]=[current_square[0]-2,current_square[1]-1] 

  available_moves[1]=[current_square[0]-1,current_square[1]-2] 
  
  available_moves[2]=[current_square[0]+1,current_square[1]-2] 
  
  available_moves[3]=[current_square[0]+2,current_square[1]-1] 
  
  available_moves[4]=[current_square[0]-2,current_square[1]+1] 
  
  available_moves[5]=[current_square[0]-1,current_square[1]+2]
  
  available_moves[6]=[current_square[0]+1,current_square[1]+2]
  
  available_moves[7]=[current_square[0]+2,current_square[1]+1]

  i = 0

  while i <= 7
    #puts "checking #{available_moves[i]}"
    available_moves[i].delete_if {|coordinate| coordinate < 1 || coordinate > 8}
    #puts "it's now #{available_moves[i]}"
    i += 1
  end
  #puts "After deletions, array is #{available_moves}"
  available_moves.delete_if {|nested_array| nested_array.empty?||nested_array.length != 2}
  #puts "Available moves generated: #{available_moves}"
  available_moves
end


def knight_moves(initial_square,final_square)
  initial_square.upcase!
  final_square.upcase!
  puts "initial and final squares are #{initial_square} and #{final_square}"

  initial_square_coordinates = square_to_coordinates(initial_square)
  puts "coordinates of initial square are #{initial_square_coordinates}"
  final_square_coordinates = square_to_coordinates(final_square)
  puts "coordinates of final square are #{final_square_coordinates}"

  puts "The available moves of a knight from #{initial_square} are: "#{available_moves(initial_square_coordinates)}"
  #
  available_moves(initial_square_coordinates).each{|coordinates| puts coordinates_to_square(coordinates)}




end

knight_moves("d4","f2")

knight_moves("a1","f2")

knight_moves("a8","f2")


knight_moves("h4","f2")



    