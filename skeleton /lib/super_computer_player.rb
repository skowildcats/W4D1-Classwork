require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    # debugger
    node = TicTacToeNode.new(game.board, mark)
    node.children.each do |child|
      # until game.over?
        # until child.board.over?
      return child.prev_move_pos if child.winning_node?(mark) 
      # debugger
          # next
        # end
      # end
    end # check if any next move is winning
    node.children.each do |child|
      return child.prev_move_pos if !child.losing_node?(mark)
    end # check for ties
    raise "Not possible"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
