require 'test/unit'
require_relative 'tic_tac_toe'

class TicTacToeTest < Test::Unit::TestCase
  def setup
    @game = TicTacToe.new
  end

  def test_valid_input
    assert_true @game.valid_input?("1")
    assert_true @game.valid_input?("9")
    assert_false @game.valid_input?("0")
    assert_false @game.valid_input?("10")
    assert_false @game.valid_input?("invalid")
  end

  def test_valid_move
    @game.make_move(0, 0)
    assert_false @game.valid_move?(0, 0)
    assert_true @game.valid_move?(1, 1)
    assert_true @game.valid_move?(2, 2)
    assert_false @game.valid_move?(0, 3)
  end

  def test_diagonals
    @game.make_move(0, 0)
    @game.make_move(1, 1)
    @game.make_move(2, 2)
    assert_true @game.winner?

    @game = TicTacToe.new
    @game.make_move(0, 2)
    @game.make_move(1, 1)
    @game.make_move(2, 0)
    assert_true @game.winner?
  end

  def test_draw
    moves = [[0, 0], [1, 0], [2, 0],
             [0, 1], [1, 1], [2, 1],
             [0, 2], [1, 2], [2, 2]]
    moves.each { |row, col| @game.make_move(row, col) }
    assert_true @game.draw?
  end

  def test_play
    moves = [1, 2, 5, 4, 9, 6, 3, 7, 8] # Winning moves for 'X'
    moves.each { |move| @game.make_move(*@game.move_to_row_col(move)) }
    assert_equal "X wins!", @game.play.strip

    @game = TicTacToe.new
    moves = [1, 2, 5, 4, 7, 3, 6, 8, 9] # All cells occupied, no winner
    moves.each { |move| @game.make_move(*@game.move_to_row_col(move)) }
    assert_equal "It's a draw!", @game.play.strip
  end
end