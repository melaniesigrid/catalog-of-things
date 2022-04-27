module GameHelpers
  def store_data_to_json
    File.write('data/authors.json', JSON.generate(@list_authors))
    File.write('data/games.json', JSON.generate(@list_games))
  end

  def load_authors_from_json
    return unless File.exist?('data/authors.json')

    authors_arr = JSON.parse(File.read('data/authors.json'))
    authors_arr.each do |obj|
      @list_authors << Author.new(obj['first_name'], obj['last_name'], id: obj['id'])
    end
  end

  def load_games_from_json
    return unless File.exist?('data/games.json')

    games_arr = JSON.parse(File.read('data/games.json'))
    games_arr.each do |obj|
      game = Game.new(
        obj['multiplayer'],
        obj['last_played_at'],
        obj['publish_date'],
        id: obj['id'],
        archived: obj['archived']
      )
      @list_authors.find { |e| e.id == obj['author'] }.add_item(game)
      @list_games << game
    end
    @list_games.each { |e| puts e.archived }
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
