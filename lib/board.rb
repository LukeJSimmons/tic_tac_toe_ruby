class Board
  def initialize(board=[
    ['#', '#', '#'],
    ['#', '#', '#'],
    ['#', '#', '#']
  ])
    @board = board
    @current_symbol = 'X'
  end

  def print_board
    board_str = "\n  1 2 3\n"
    @board.each_with_index do |row, index|
      board_str << (index+1).to_s + ' '
      row.each_with_index do |column, index|
        board_str << column + ' '
      end
      board_str << "\n"
    end
    board_str << "\n"
    puts board_str
    self.check_for_win
    self.take_input
  end

  def take_input
    puts @current_symbol + ' - Enter column number:'
    x = gets.chomp

    if x == 'exit' || x == 'q'
      exit
    elsif x.to_i.to_s != x || x.to_i < 1 || x.to_i > 3
      puts 'Invalid Input: Please Input a Number Between 1 and 3'
      self.print_board
      return
    end

    puts @current_symbol + ' - Enter row number:'
    y = gets.chomp

    if y.to_i.to_s != y || y.to_i < 1 || y.to_i > 3
      puts 'Invalid Input: Please Input a Number Between 1 and 3'
      self.print_board
      return
    end

    self.place(x.to_i-1, y.to_i-1)
  end

  def place(x, y)

    if @board[y][x] == '#'
      @board[y][x] = @current_symbol
      @current_symbol = @current_symbol == 'X' ? 'O' : 'X'
    else
      puts 'Place Taken: Please enter valid input'
    end

    self.print_board
  end

  def check_for_win
    #Row Wins
    if @board.any? { |row| row.all? { |column| column == 'X' }  }
      puts 'X Wins!'
      exit
    elsif @board.any? { |row| row.all? { |column| column == 'O' }  }
      puts 'O Wins!'
      exit
    end

    #Column Wins
    i = 0
    until i == 3 do
      columns = []

      j = 0
      until j == 3 do
        columns << @board[j][i]
        j += 1
      end

      if columns.all? { |row| row == 'X' }
        puts 'X Wins!'
        exit
      elsif columns.all? { |row| row == 'O' }
        puts 'O Wins!'
        exit
      end

      i += 1
    end

    #Diaganol Wins
    if @board[0][0] == 'X' && @board[1][1] == 'X' && @board[2][2] == 'X'
      puts 'X Wins!'
      exit
    elsif @board[0][0] == 'O' && @board[1][1] == 'O' && @board[2][2] == 'O'
      puts 'O Wins!'
      exit
    elsif @board[2][0] == 'X' && @board[1][1] == 'X' && @board[0][2] == 'X'
      puts 'X Wins!'
      exit
    elsif @board[2][0] == 'O' && @board[1][1] == 'O' && @board[0][2] == 'O'
      puts 'O Wins!'
      exit
    end

    #Cat Game
    if @board.none? { |row| row.any? { |column| column == '#' } } && @board.any? { |row| row.any? { |column| column == 'X' } }
      puts "Cat Game!"
      exit
    end
  end
  
end