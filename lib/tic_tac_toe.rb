class TicTacToe
  def initialize
    print 'Enter board size: '
    @board_size = gets.chomp.to_i
    print 'Enter X symbol: '
    @x_symbol = gets.chomp
    print 'Enter O symbol: '
    @o_symbol = gets.chomp
    @board_state = Array.new(@board_size) { Array.new(@board_size, '-') }
    @x_symbol = 'X' if @x_symbol.empty?
    @o_symbol = 'O' if @o_symbol.empty?
    @player = @x_symbol.dup
  end

  def run_game
    puts
    puts 'Tic Tac Toe'
    puts
    until winning_position?
      display_board
      puts "#{@player} moves ->"
      x, y = get_user_input
      update_board(x, y)
      switch_player
    end
    display_board
    switch_player
    puts "#{@player} has won!"
  end

  private

  def display_board
    @board_state.each { |row| puts row.join ' ' }
    puts
  end

  def legal_move?(x, y)
    @board_state[@board_state.size - y][x - 1] == '-' &&
      x <= @board_state[0].size && y <= @board_state.size
  end

  def valid_input?(x, y)
    x.to_i.to_s == x && y.to_i.to_s == y
  end

  def get_user_input
    loop do
      print 'Enter x-coordinate: '
      x = gets.chomp
      print 'Enter y-coordinate: '
      y = gets.chomp
      unless valid_input?(x, y)
        puts 'Invalid input entered - please try again'
        next
      end
      x, y = x.to_i, y.to_i
      if legal_move?(x, y)
        puts
        return x, y
      else
        puts 'Illegal move detected - please try again'
      end
    end
  end

  def update_board(x, y)
    @board_state[@board_state.size - y][x - 1] =
      @player == @x_symbol ? @x_symbol : @o_symbol
  end

  def switch_player
    @player = @player == @x_symbol ? @o_symbol : @x_symbol
  end

  def possible_winning_positions
    result_ary = []
    @board_state.each { |row| result_ary << row }
    (0...@board_state.size).each do |i|
      column = []
      (0...@board_state.size).each { |j| column << @board_state[j][i] }
      result_ary << column
    end
    result_ary << (0...@board_state.size).map { |i| @board_state[i][i] }
    result_ary <<
      (0...@board_state.size).map do |i|
        @board_state[i][@board_state.size - 1 - i]
      end
    result_ary
  end

  def winning_position?
    possible_winning_positions.any? do |line|
      [@x_symbol * @board_size, @o_symbol * @board_size].include? line.join
    end
  end
end

tic_tac_toe = TicTacToe.new
tic_tac_toe.run_game
