class ConnectFourEngine
  attr_reader :turn

  ROWS = 6
  COLUMNS = 7
  WIN_LINK_LENGTH = 4
  
  def initialize
    @board = Array.new(ROWS) { Array.new(COLUMNS, :EMPTY) }
    @turn = :RED
    @move_count = 0
    @last_played_row = -1
    @last_played_col = -1
  end

  def piece_at(row, col)
    @board[row][col]
  end

  def toggle_turn
    @turn == :RED ? (@turn = :YELLOW) : (@turn = :RED)
  end

  def reset_board
    @board = Array.new(ROWS) { Array.new(COLUMNS, :EMPTY) }
    @turn = :RED
    @move_count = 0
  end

  def add_to_column(col)
    added = false
    if @board[0][col] == :EMPTY
      add_to_lowest_empty_row(col)
      @move_count += 1
      added = true
    end
    added
  end

  def add_to_lowest_empty_row(col)
    (ROWS-1).downto(0) do |i|
      row = @board[i]
      if (row[col] == :EMPTY)
        row[col] = @turn
        @last_played_row = i
        @last_played_col = col
        break
      end
    end
  end

  def check_draw
    @move_count == ROWS*COLUMNS
  end

  def check_win
    check_win_S || check_win_NE_SW || 
      check_win_W_E || check_win_NW_SE
  end

  private

  def check_win_S
    count_S(@last_played_row+1, @last_played_col, 0) + 1 >= WIN_LINK_LENGTH
  end

  def check_win_NE_SW
    count_NE(@last_played_row-1, @last_played_col+1, 0) +
      count_SW(@last_played_row+1, @last_played_col-1, 0) + 1 >= WIN_LINK_LENGTH
  end

  def check_win_W_E
    count_E(@last_played_row, @last_played_col+1, 0) +
      count_W(@last_played_row, @last_played_col-1, 0) + 1 >= WIN_LINK_LENGTH
  end

  def check_win_NW_SE
    count_NW(@last_played_row-1, @last_played_col-1, 0) +
      count_SE(@last_played_row+1, @last_played_col+1, 0) + 1 >= WIN_LINK_LENGTH
  end

  def count_E(row, col, count)
    if col < COLUMNS && @board[row][col] == @turn
      count = count_E(row, col+1, count+1)
    end
    count
  end

  def count_W(row, col, count)
    if col >= 0 && @board[row][col] == @turn
      count = count_W(row, col-1, count+1)
    end
    count
  end

  def count_S(row, col, count)
    if row < ROWS && @board[row][col] == @turn
      count = count_S(row+1, col, count+1)
    end
    count
  end

  def count_NE(row, col, count)
    if row >= 0 && col < COLUMNS && @board[row][col] == @turn
      count = count_NE(row-1, col+1, count+1)
    end
    count
  end

  def count_SE(row, col, count)
    if row < ROWS && col < COLUMNS && @board[row][col] == @turn
      count = count_SE(row+1, col+1, count+1)
    end
    count
  end

  def count_SW(row, col, count)
    if row < ROWS && col >= 0 && @board[row][col] == @turn
      count = count_SW(row+1, col-1, count+1)
    end
    count
  end

  def count_NW(row, col, count)
    if row >= 0 && col >= 0 && @board[row][col] == @turn
      count = count_NW(row-1, col-1, count+1)
    end
    count
  end
end
