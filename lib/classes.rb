class Board
  attr_accessor :board

  def initialize
    @board = [
      Array.new(7,"-"),
      Array.new(7,"-"),
      Array.new(7,"-"),
      Array.new(7,"-"),
      Array.new(7,"-"),
      Array.new(7,"-")
    ]
  end

  def column_full? column
    t_board = @board.transpose
    t_board[column-1].each do |mark|
      return false if mark == "-"
    end
    return true
  end


  def display_board
    @board.each do |row|
      print " |"
      row.each do |column|
        print "  #{column}  |"
      end
      puts ""
      puts " ____________________________________________"
    end
  end
end

class Game
  def initialize
    @board = Board.new
    @player = "O"
    @game_over = false
  end

  def play
    while @game_over == false
      @board.display_board
      input = get_input
      mark_board(input)
      if check_game_end
        @game_over = true
        puts "'#{@player}' wins!"
      end
      change_player
    end
    @board.display_board
  end

  def board
    @board.board
  end

  def get_input
    input = gets.chomp.to_i
    if input.is_a? Integer
      if input.between?(1,7)
        return input if !@board.column_full?(input)
      end
    end
    puts "Wrong Input"
    get_input
  end

  def change_player
    if @player == "O"
      @player = "X"
    else
      @player = "O"
    end
  end

  def mark_board column
    marked = false

    @board.board.reverse.each do |row|
      if row[column-1] == "-"
        row[column-1] = @player
        marked = true
        break
      else
        next
      end
    end

    return false if marked == false
  end

  def check_game_end
    if horizontal_win || vertical_win || diagonal_win
      return true
    end
  end

  def horizontal_win
    @board.board.each do |row|
      column = 0
      while (column < 4) do
        if (row[column] == @player &&
            row[column+1] == @player &&
            row[column+2] == @player &&
            row[column+3] == @player)
           return true
        end
        column += 1
      end
    end
    return false
  end

  def vertical_win
    row = 0
    while row < 3 do
      @board.board[row].each_with_index do |column, index|
        if (column == @player &&
            @board.board[row+1][index] == @player &&
            @board.board[row+2][index] == @player &&
            @board.board[row+3][index] == @player)
            return true
        end
      end
      row += 1
    end
    return false
  end

  def diagonal_win
    row = 0
    while row < 3 do
      @board.board[row].each_with_index do |column, index|
        if index < 3
          return true if check_right_diagonal(row, index, column)
        elsif index == 3
          return true if check_right_diagonal(row, index, column)
          return true if check_left_diagonal(row, index, column)
        else
          return true if check_left_diagonal(row, index, column)
        end
      end
      row += 1
    end
    return false
  end

  def check_left_diagonal(row, index, column)
    if (column == @player &&
        @board.board[row+1][index-1] == @player &&
        @board.board[row+2][index-2] == @player &&
        @board.board[row+3][index-3] == @player)
      return true
    end
  end

  def check_right_diagonal(row, index, column)
    if (column == @player &&
        @board.board[row+1][index+1] == @player &&
        @board.board[row+2][index+2] == @player &&
        @board.board[row+3][index+3] == @player)
      return true
    end
  end
end
