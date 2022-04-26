module GameHelpers
  def list_games
    puts 'No game registered yet' if @list_games.empty?
    puts "\n----- GAMES -----" unless @list_games.empty?
    @list_games.each_with_index.each do |e, i|
      author = "#{e.author.first_name} #{e.author.last_name}"
      prop_game = "Multiplayer: #{e.multiplayer}, Last played at: #{e.last_played_at}"
      puts "#{i}) Publish date: #{e.publish_date}, Author: #{author}, #{prop_game}"
    end
  end

  def list_authors
    puts "\nNo author registered yet" if @list_authors.empty?
    puts "\n------ AVAILABLE AUTHORS ------" unless @list_authors.empty?
    @list_authors.each_with_index.each { |e, i| puts "#{i}) #{e.first_name} #{e.last_name}" }
    puts
  end

  def load_authors_from_json
    if File.exist?('data/authors.json')
      authors_arr = JSON.parse(File.read('data/authors.json'))
      authors_arr.each do |obj|
        @list_authors << Author.new(obj['first_name'], obj['last_name'], id: obj['id'])
      end
    else
      []
    end
  end

  def load_games_from_json
    if File.exist?('data/games.json')
      items_arr = JSON.parse(File.read('data/games.json'))
      items_arr.each do |obj|
        game = Game.new(
          obj['multiplayer'],
          obj['last_played_at'],
          obj['publish_date'],
          id: obj['id'],
          archived: obj['archived']
        )
        game.author = @list_authors.find { |e| e.id == obj['author'] }
        @list_games << game
      end
    else
      []
    end
  end

  def store_data_to_json
    File.write('data/authors.json', JSON.generate(@authors))
    File.write('data/games.json', JSON.generate(@games))
  end

  def load_data_from_json
    load_authors_from_json
    load_games_from_json
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
