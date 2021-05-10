require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # p self.board.rows.each {|el| p el}
    if self.board.over? 
      return self.board.winner != evaluator && self.board.won?
    end

    # if self.board.over? && (self.board.winner == evaluator || self.board.winner.nil?)
    #   #checking if win or tied
    #   return false
    # elsif self.board.over? && self.board.winner != evaluator
    #   #checking if 
    #   return true
    # end
    
    temp = self.children.select {|el| self.board.rows != el.board.rows}

    if evaluator != @next_mover_mark #check opponent move
      temp.any? {|child| child.losing_node?(evaluator) == true}
    else
      temp.all? {|child| child.losing_node?(evaluator) == true}
    end
  end

  def winning_node?(evaluator)
    if self.board.over? 
      return self.board.winner == evaluator
    end
    
    temp = self.children.select {|el| self.board.rows != el.board.rows}

    if evaluator == @next_mover_mark #check player move
      temp.any? {|child| child.winning_node?(evaluator) == true}
    else
      temp.all? {|child| child.winning_node?(evaluator) == true}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    childs = []
    # grid = @board.dup
    # grid[[i,j]] = next_mover_mark
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |el, j|
        grid = @board.dup
        grid[[i,j]] = next_mover_mark if @board.empty?([i,j])
        prev_mov_pos = [i,j] if @board.empty?([i,j])
        childs << TicTacToeNode.new(grid, next_mover_mark == :x ? :o : :x, prev_mov_pos) 
      end
    end
    childs
  end
end

node = TicTacToeNode.new(Board.new, :x)
      node.board[[0, 0]] = :x
    node.board[[2, 0]] = :x
    node.board[[1, 0]] = :o
    node.board[[2, 1]] = :o

node.board.rows.each do |el|
  p el
end    
# node.children.flatten.each do |el|
#   p el.board.rows
# end
# puts
# # p node.children
# temp = node.children.select {|el| node.board.rows != el.board.rows}
# temp.each do |el|
#   p el.board.rows
# end

# puts
# node.children[0].children.flatten.each do |el|
#   p el.board.rows
# end
# puts
# node.children[1].children.flatten.each do |el|
#   p el.board.rows
# end
# puts