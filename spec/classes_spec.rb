# 6 x 7 board
# game ends if:
# -a player makes 4-in-a-row (horizontal, diagonal, vertical)
# -board is full
# players take turn to input a column to drop their piece

require 'classes'

describe "Connect-Four Game" do

  before(:each) do
    @board = Board.new
    @game = Game.new
    @ex_board = @board.board
  end

  let(:empty_board) do
    array = []
    6.times do array.push(Array.new(7,"-"))
    end
    return array
  end

  describe Board do
    context "#board" do
      it "initializes the board with empty array" do
        expect(@board.board).to eql(empty_board)
      end
    end
    context "#display_board" do
      it "shows the board" do
        expect(@board.display_board)
      end
    end
    context "#column_full?" do
      it "checks if the column is full" do
        index = 5
        6.times do
          @board.board[index][0] = "O"
          index -= 1
        end
        expect(@board.column_full?(1)).to be true
      end
    end
  end

  describe Game do
    context "#change_player" do
      it "changes the mark of player" do
        @game.mark_board(1)
        @ex_board[5][0] = "O"
        @game.change_player
        expect(@game.board).to eql(@ex_board)
        @game.mark_board(2)
        @ex_board[5][1] = "X"
        @game.change_player
        expect(@game.board).to eql(@ex_board)
      end
    end
    context "#mark_board" do
      it "marks_the_board with input as column: ex. 4" do
        @game.mark_board(4)
        @ex_board[5][3] = "O"
        expect(@game.board).to eql(@ex_board)
      end
    end
    context "#check_game_end" do
      it "checks the board for horizontal win" do
        index = 1
        4.times do
          @game.mark_board(index)
          @game.mark_board(index)
          index += 1
        end
        expect(@game.check_game_end).to be true
      end
      it "checks the board for vertical win" do
        4.times do
          @game.mark_board(4)
          @game.mark_board(3)
        end
        expect(@game.check_game_end).to be true
      end
      it "check the board for diagonal win" do
        index = 1
        count = 3

        3.times do
          count.times do
            @game.mark_board(index)
            @game.change_player
          end
          index += 1
          count -= 1
        end

        index = 1

        3.times do
          @game.mark_board(index)
          @game.change_player
          @game.mark_board(5)
          @game.change_player
          index += 1
        end

        @game.mark_board(4)
        
        expect(@game.check_game_end).to be true
      end
    end
  end
end
