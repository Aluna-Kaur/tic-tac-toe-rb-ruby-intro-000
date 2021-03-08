WIN_COMBINATIONS = [
 [0,1,2],
 [3,4,5],
 [6,7,8],
 [0,3,6],
 [1,4,7],
 [2,5,8],
 [0,4,8],
 [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player = "X")
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    puts system('clear')
    move(board, index, current_player)
    display_board(board)
    if over?(board)
      won? ? (puts "Congratulations #{winner(board)}") : (puts "The game is a draw")
    else
      turn(board)
    end
  else
    turn(board)
  end
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  return board.map{|space| space != " "}.count(true)
end

def play(board)
  while turn_count(board) < 10 && !over?(board)
    turn(board)
  end
end


def won?(board)
  result = false
  WIN_COMBINATIONS.each { |win_combination|

    win_indexs = [
      win_combination[0],
      win_combination[1],
      win_combination[2]
  ]
    board_positions = [
      board[win_indexs[0]],
      board[win_indexs[1]],
      board[win_indexs[2]]
  ]
  #use of the full? function takes in a partial board a verifies no spaces are empty
    if (board_positions[0] == board_positions[1] && board_positions[1] == board_positions[2]) && full?(board_positions)
      result = win_combination
    end
  }
  return result
end

def full?(board)
  return !board.any? {|position| position == " " || position.nil?}
end

def draw?(board)
   return full?(board) && !won?(board)
 end

def over?(board)
  return full?(board) || won?(board) || draw?(board)
end

def winner(board)
  win_condition = won?(board)
  if win_condition != false
    return board[win_condition[0]]
  else
    return nil
  end
end
