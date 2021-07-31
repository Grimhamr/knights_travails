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
class Node
  attr_accessor :square, :parent_node, :child_nodes
    def initialize(square,parent_node)
      @square = square
      @parent_node = parent_node
      @child_nodes = []
     
    end

end
class KnightMoves

  def initialize(initial_square,final_square)

    @initial_square = initial_square
    @final_square = final_square

  end
  
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
    #puts "finding available move 0 from #{current_square} "
    available_moves[0]=[current_square[0]-2,current_square[1]-1] 
    #puts "finding available move 1"
    available_moves[1]=[current_square[0]-1,current_square[1]-2] 
    #puts "finding available move 2"

    available_moves[2]=[current_square[0]+1,current_square[1]-2] 
    #puts "finding available move 3"

    available_moves[3]=[current_square[0]+2,current_square[1]-1] 
   # puts "finding available move 4"

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


  def knight_moves
    @initial_square.upcase!
    @final_square.upcase!
    puts "initial square: #{@initial_square} \nfinal square: #{@final_square}"

    @initial_square_coordinates = square_to_coordinates(@initial_square)
    puts "coordinates of initial square are #{@initial_square_coordinates}"
    @final_square_coordinates = square_to_coordinates(@final_square)
    puts "coordinates of final square are #{@final_square_coordinates}"

    build_move_tree(@initial_square,@final_square)

    


  end
  
  def track_parents(node, parents_array = [])
    
    unless node.nil?
      #puts "tracking parents of #{node.square}" unless node.parent_node.nil?
      
      parents_array.insert(0,node.square)
      track_parents(node.parent_node,parents_array)
    end
    parents_array
  end

  def generate_children(node = root, current_square = @initial_square, moves_so_far = 0)
    if @generated_nodes.include?(node.square)
      #puts "generated nodes list: #{@generated_nodes} contains node of square: #{node.square}. not proceeding"
      return
    end
    #puts "generating children for square #{current_square}"
    puts "The available moves of a knight from #{current_square} are: "
    next_moves = available_moves(square_to_coordinates(current_square)).map{|coordinates| coordinates_to_square(coordinates)}
    puts next_moves #array
    i = 0
 #generate child nodes for next_moves 
    while i < next_moves.length
      node.child_nodes[i] = Node.new(next_moves[i],node) 
     # puts "child node of #{node.square} generated:"
      p node.child_nodes[i].square
      i += 1
    end
   
   #puts "parent node of #{node.square} is: #{node.parent_node.square}" unless node.parent_node.nil?
    @generated_nodes.push(node.square)
    @generated_nodes = @generated_nodes.uniq
   # p "we have seen all moves from #{node.square}; we shouldn't recheck it"
    #puts @generated_nodes
    #p node
    moves_so_far += 1
 #check if child nodes.data == final_square
    if next_moves.include?(@final_square)
      puts "#{@final_square} found in next moves #{next_moves}"
      @results_hash[moves_so_far] = track_parents(node)

      @number_of_moves.push(moves_so_far)
      #track parent nodes

      return
      
    else
      #if not
      puts "final square #{@final_square} not found in next moves #{next_moves}"
      #@generated_nodes = (@generated_nodes + next_moves).uniq
      #puts "Nodes already generated are: #{@generated_nodes}"
      i = 0
      node.child_nodes.compact!
      while i < node.child_nodes.length
        #puts "examining #{node.child_nodes} for potential recursion"
        #puts "recursing to generate children for #{node.child_nodes[i].square}" unless node.child_nodes[i].nil?
        generate_children(node.child_nodes[i],node.child_nodes[i].square,moves_so_far)
        i += 1
      end
      
   
    end
  end

  def build_move_tree(initial_square,final_square)
    #create root node of initial square
    @results_hash = {}
    @number_of_moves = []
    @generated_nodes = []
    root = Node.new(initial_square,nil)
    puts "Knight starts off at square #{root.square}"
    
    generate_children(root)
    
    puts "The knight travelled to #{@final_square} from #{@initial_square} in #{@number_of_moves.min} moves"

    p @results_hash



  end
end
d4_to_f2 = KnightMoves.new("d4","f2")
d4_to_f2.knight_moves #D4 -> E6 -> C5 -> D3 -> F2

#a1_to_b3 = KnightMoves.new("a1","b3")
#a1_to_b3.knight_moves
=begin
a8_to_f2 = KnightMoves.new("a8","f2")
a8_to_f2.knight_moves

h4_to_f2 = KnightMoves.new("h4","f2")
h4_to_f2.knight_moves

=end
    