class Game
  attr_accessor :board, :player_1, :player_2


  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    if board.turn_count % 2 == 0
      player_1
    else
      player_2
    end
  end

  def over?
    won? || draw?
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combinations|
     board.cells[win_combinations[0]] == board.cells[win_combinations[1]] && board.cells[win_combinations[1]] == board.cells[win_combinations[2]] && board.taken?(win_combinations[0]+1)
  end
  end

  def draw?
    if !won? && board.full?
      true
    else
      false
    end
  end

  def winner
    if won?
      winning_array = won?
      board.cells[winning_array[0]]
    end
  end

  def turn
    player = current_player
    current_move = player.move(@board)
    if @board.valid_move?(current_move)
      puts "#{@board.turn_count+1}"
      @board.display
      @board.update(current_move, player)
    else
      turn
    end
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

end
