module GameAuthorManager
  def add_author
    print 'First name: '
    first_name = gets.chomp.to_s
    print 'Last name: '
    last_name = gets.chomp.to_s
    @authors << Author.new(first_name, last_name)
    @authors[-1]
  end

  def select_valid_author_option(option, start, endi)
    until option == 'n' || (option.to_i >= start && option.to_i <= endi)
      print 'Please enter a valid option: '
      option = gets.chomp.strip.downcase
    end
    option
  end

  def select_author
    puts "\nSelect an author from the following list by number OR create a new one (n)" unless @authors.empty?
    @authors.each_with_index.each { |e, i| puts "#{i + 1}) #{e.first_name} #{e.last_name}" }
    puts 'n) Add a new author' unless @authors.empty?
    print "\nPress n key to add an author (n): " if @authors.empty?
    option = gets.chomp.strip
    option = select_valid_author_option(option.strip.downcase, 1, @authors.length)
    author = add_author if option.to_i.zero?
    author = @authors[option.to_i - 1] unless option.to_i.zero?
    author
  end

  def load_authors_json
    if File.exist?('data/authors.json')
      authors_arr = JSON.parse(File.read('data/authors.json'))
      authors_arr.each do |obj|
        @authors << Author.new(obj['first_name'], obj['last_name'], id: obj['id'])
      end
    else
      []
    end
  end

  def load_games_json
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
        game.author = @authors.find { |e| e.id == obj['author'] }
        @games << game
      end
    else
      []
    end
  end
end
