require_relative 'lib/app'

def display_menu
  puts "\n\nPlease choose an option by entering a number:"
  puts '1 - List all books'
  puts '2 - List all music albums'
  puts '3 - List all games'
  puts '4 - List all genres'
  puts '5 - List all labels'
  puts '6 - List all authors'
  puts '7 - Add a book'
  puts '8 - Add a music album'
  puts '9 - Add a game'
  puts '10 - Exit'
end

def main
  app = App.new
  option = 0
  while option != 13
    display_menu
    print '[Input the number]: '
    option = app.select_option
  end
  puts "Thank you for using this app!\n\n"
end

main
