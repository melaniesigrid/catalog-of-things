require_relative 'classes/app'

def display_menu
  puts "\n\nPlease choose an option by entering a number:"
  puts '1 - List all books'
  puts '2 - List all music albums'
  puts '3 - List all movies'
  puts '4 - List all games'
  puts '5 - List all genres'
  puts '6 - List all labels'
  puts '7 - List all authors'
  puts '8 - List all sources'
  puts '9 - Add a book'
  puts '10 - Add a music album'
  puts '11 - Add a movie'
  puts '12 - Add a game'
  puts '13 - Exit'
end

def main
  app = App.new
  option = 0
  while option != 7
    display_menu
    print '[Input the number]: '
    option = gets.chomp.to_i
    execute_menu_options(app, option) if option >= 1 && option <= 6
  end
  puts "Thank you for using this app!\n\n"
end

main
