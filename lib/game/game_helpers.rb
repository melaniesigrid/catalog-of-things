module GameHelpers
  def store_data_to_json
    puts 'store data to json'
    File.write('data/authors.json', JSON.generate(@list_authors))
    File.write('data/games.json', JSON.generate(@list_games))
  end

  def load_authors_from_json
    if File.exist?('data/authors.json')
      authors_arr = JSON.parse(File.read('data/authors.json'))
      if authors_arr
        authors_arr.each do |obj|
          @list_authors << Author.new(obj['first_name'], obj['last_name'], id: obj['id'])
        end
      end
    end
  end

  def load_games_from_json
    if File.exist?('data/games.json')
      items_arr = JSON.parse(File.read('data/games.json'))
      if items_arr
        items_arr.each do |obj|
          game = Game.new(
            obj['multiplayer'],
            obj['last_played_at'],
            obj['publish_date'],
            id: obj['id'],
            archived: obj['archived']
          )
          author = @list_authors.find { |e| e.id == obj['author'] }
          author.add_item(game)
          @list_games << game
        end
      end
    end
  end

  def validates_date
    begin
      date = gets.chomp
      date = Date.parse(date)
    rescue ArgumentError
      print 'Please enter date in the format YYYY/MM/DD: '
      retry
    end
    date
  end
end
