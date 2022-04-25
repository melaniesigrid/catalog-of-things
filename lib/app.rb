class App
  def select_option
    choice = gets.chomp.strip.to_i
    case choice
    when 1, 2, 3, 4, 5, 6
      list_tasks(choice)
    when 7, 8, 9
      add_tasks(choice)
    when 10
      'Exit'
    else
      puts 'Unknown option, please select from the options menu.'
    end
  end

  def list_tasks(choice)
    case choice
    when 1
      list_books
    when 2
      list_music_albums
    when 3
      list_games
    when 4
      list_genres
    when 5
      list_labels
    when 6
      list_authors
    end
  end

  def add_tasks(choice)
    case choice
    when 7
      add_book
    when 8
      add_music_album
    when 9
      add_game
    end
  end
end
