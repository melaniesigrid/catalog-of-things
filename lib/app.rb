require_relative './music/music_menu'
require_relative './game/game_menu'

class App
  def initialize
    @music_menu = MusicMenu.new
    @game_menu = GameMenu.new
  end

  def save_data
    @music_menu.write_to_json
    @game_menu.store_data_to_json
  end

  def select_option
    choice = gets.chomp.strip.to_i
    case choice
    when 1, 2, 3, 4, 5, 6
      list_tasks(choice)
    when 7, 8, 9
      add_tasks(choice)
    when 10
      save_data
    else
      puts 'Unknown option, please select from the options menu.'
    end
  end

  def list_tasks(choice)
    case choice
    when 1
      list_books
    when 2 then @music_menu.print_albums
    when 3 then @game_menu.list_games
    when 4 then @music_menu.print_genres
    when 5
      list_labels
    when 6 then @game_menu.list_authors
    end
  end

  def add_tasks(choice)
    case choice
    when 7
      add_book
    when 8 then @music_menu.album_menu
    when 9 then @game_menu.add_game
    end
  end
end
