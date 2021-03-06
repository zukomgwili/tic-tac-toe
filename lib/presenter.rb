class Presenter
  def alert(message)
    puts message
  end

  def prompt
    gets.chomp.strip.to_i
  end

  def display_rules(rules)
    formatted_rules = 'RULES'
    formatted_rules += rules.each_with_index.reduce("\n") do |acc, (rule, index)|
      acc + "#{index + 1}. #{rule}.\n"
    end
    formatted_rules += "\n"
    puts formatted_rules
  end

  def display_board(board)
    border = " -----------\n"

    ascii_board = border
    ascii_board += build_row(board, 0, 1, 2)
    ascii_board += border
    ascii_board += build_row(board, 3, 4, 5)
    ascii_board += border
    ascii_board += build_row(board, 6, 7, 8)
    ascii_board += border

    puts ascii_board
  end

  def update_board(board)
    display_board(board)
  end

  def game_options(options)
    formatted_options = options.each_with_index.reduce("OPTIONS\n") do |text, (option, index)|
      text + "#{index}. #{option}\n"
    end
    formatted_options += "\nPlease select an option:"
    puts formatted_options
  end

  private

  def build_row(board, *args)
    board.values_at(*args).each_with_index.reduce('|') do |row, (mark, index)|
      row += " #{mark.length.zero? ? ' ' : mark} |"
      row += "\n" if index == 2
      row
    end
  end
end
