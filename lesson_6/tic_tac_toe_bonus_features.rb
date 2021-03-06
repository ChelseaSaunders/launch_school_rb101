require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diag

score = { player: 0, computer: 0, tie: 0 }

MAX_WIN = 5

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop: disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  prompt "You're #{PLAYER_MARKER}.  Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, punctuation = ', ', conjunction = 'or')
  if arr.length == 1
    arr.join
  elsif arr.length == 2
    arr[-1] = arr[-1].to_s.prepend(conjunction, ' ')
    arr.join(' ')
  elsif arr.length >= 3
    arr[-1] = arr[-1].to_s.prepend(conjunction, ' ')
    arr.join(punctuation)
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square #{joinor(empty_squares(brd))}:"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry that's not a vaild choice."
  end

  brd[square] = PLAYER_MARKER
end

def offense?(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2 && brd.values_at(*line).count(PLAYER_MARKER) == 0
      return true
    end
  end
  false
end

def defense?(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2 && brd.values_at(*line).count(COMPUTER_MARKER) == 0
      return true
    end
  end
  false
end

def offensive_play(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      line.each do |position|
        if brd[position] == ' '
          brd[position] = COMPUTER_MARKER
        end
      end
    end
  end
end

def defensive_play(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2
      line.each do |position|
        if brd[position] == ' '
          brd[position] = COMPUTER_MARKER
        end
      end
    end
  end
end

def computer_places_piece!(brd)
  if offense?(brd)
    offensive_play(brd)
  elsif defense?(brd)
    defensive_play(brd)
  elsif empty_squares(brd).include?(5)
    brd[5] = COMPUTER_MARKER
  else
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def assign_winner(brd, score_hsh)
  if detect_winner(brd) == 'Player'
    score_hsh[:player] += 1
  elsif detect_winner(brd) == 'Computer'
    score_hsh[:computer] += 1
  elsif board_full?(brd) == true
    score_hsh[:tie] += 1
  end
end

def declare_winner(brd, score_hsh)
  if someone_won?(brd)
    prompt "#{detect_winner(brd)} won!"
  else
    prompt "It's a tie!"
  end

  assign_winner(brd, score_hsh)
end

def display_win_tally(hash)
  prompt "Player won #{hash[:player]} times!"
  prompt "Computer won #{hash[:computer]} times!"
  prompt "You tied #{hash[:tie]} times!"
end

def game_champion?(hash)
  hash[:player] == MAX_WIN || hash[:computer] == MAX_WIN
end

def display_game_champion(hash)
  puts "Player is the champion!" if hash[:player] == 5
  puts "Computer is the champion!" if hash[:computer] == 5
end

def alternate_player(current_player)
  if current_player == 'computer'
    current_player = 'user'
  elsif current_player == 'user'
    current_player = 'computer'
  end
  current_player
end

def place_piece!(brd, current_player)
  computer_places_piece!(brd) if current_player == 'computer'
  player_places_piece!(brd) if current_player == 'user'
end

def play_again?
  answer = ''
  loop do
    prompt "Play again? (y or n)"
    answer = gets.chomp.downcase
    break if answer == "yes" || answer == 'y'
    break if answer == "no" || answer == 'n'
    puts "Sorry, that wasn't a valid input."
  end

  true if answer == "yes" || answer == 'y'
end

def reset_game_tally(hash)
  hash[:player] = 0
  hash[:computer] = 0
  hash[:tie] = 0
end

# MAIN GAME

loop do
  board = initialize_board

  current_player = 'user'

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  declare_winner(board, score)

  display_win_tally(score)

  if game_champion?(score)
    display_game_champion(score)
    reset_game_tally(score)
  end

  break unless play_again?
end

prompt "Thanks for playing Tic Tac Toe! Goodbye."
