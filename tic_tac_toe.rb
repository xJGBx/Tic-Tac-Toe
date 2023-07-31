class TicTacToe
    def initialize
      @board = Array.new(3) { Array.new(3, " ") }
      @current_player = "X"
    end
  
    def display_board
      puts "-------------", *@board.map { |row| "| #{row.join(' | ')} |" }, "-------------"
    end
  
    def get_move
      puts "#{@current_player}'s turn. Enter a number (1-9) to make your move:"
      input = gets.chomp
  
      return move_to_row_col(input.to_i) if valid_input?(input)
  
      puts "Invalid input. Please enter a number from 1 to 9. Try again."
      get_move
    end
  
    def valid_input?(input)
      input.match?(/^\d$/) && (1..9).include?(input.to_i)
    end
  
    def move_to_row_col(move)
      row, col = (move - 1).divmod(3)
      return [row, col] if valid_move?(row, col)
  
      puts "Invalid move. The cell is already taken. Try again."
      get_move
    end
  
    def valid_move?(row, col)
      @board[row][col] == " "
    end
  
    def make_move(row, col)
      @board[row][col] = @current_player
    end
  
    def switch_player
      @current_player = @current_player == "X" ? "O" : "X"
    end
  
    def winner?
      winning_lines = @board + @board.transpose + diagonals
      winning_lines.any? { |line| line.uniq.size == 1 && line[0] != " " }
    end
  
    def diagonals
      [[@board[0][0], @board[1][1], @board[2][2]], [@board[0][2], @board[1][1], @board[2][0]]]
    end
  
    def draw?
      !@board.flatten.include?(" ")
    end
  
    def play
      puts "Welcome to Tic-Tac-Toe!"
      display_board
      until winner? || draw?
        make_move(*get_move)
        display_board
        switch_player
      end
  
      puts winner? ? "#{@current_player} wins!" : "It's a draw!"
    end
  end
  
  # Start the game
  TicTacToe.new.play