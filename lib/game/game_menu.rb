require_relative 'author'
require_relative 'game'
require_relative 'game_helpers'
require 'json'

class GameMenu
  include GameHelpers

  def initialize
    @list_authors = []
    @list_games = []
    load_authors_from_json
    load_games_from_json
  end

  def add_game
    puts "\n----- ADDING A NEW GAME -----"
    print "\nPublish date [yyyy/mm/dd]: "
    publish_date = validates_date
    print 'Multiplayer [y/n]: '
    multiplayer = gets.chomp.to_s
    multiplayer = multiplayer.downcase == 'y'
    print 'Last played at [yyyy/mm/dd]: '
    last_played_at = validates_date
    game = Game.new(multiplayer, last_played_at, publish_date)
    select_author.add_item(game)
    @list_games << game
    puts "Game created successfully\n\n"
  end

  def select_author
    puts "\nSelect an author from the following list by number OR create a new one (n)" unless @list_authors.empty?
    @list_authors.each_with_index.each { |e, i| puts "#{i + 1}) #{e.first_name} #{e.last_name}" }
    puts 'n) Add a new author' unless @list_authors.empty?
    print "\nPress n key to add an author (n): " if @list_authors.empty?
    option = gets.chomp.strip
    option = select_valid_author_option(option.strip.downcase, 1, @list_authors.length)
    author = add_author if option.to_i.zero?
    author = @list_authors[option.to_i - 1] unless option.to_i.zero?
    author
  end

  def select_valid_author_option(option, first, last)
    until option == 'n' || (option.to_i >= first && option.to_i <= last)
      print 'Please enter a valid option: '
      option = gets.chomp.strip.downcase
    end
    option
  end

  def add_author
    print 'First name: '
    first_name = gets.chomp.to_s
    print 'Last name: '
    last_name = gets.chomp.to_s
    @list_authors << Author.new(first_name, last_name)
    @list_authors[-1]
  end

  def list_games
    puts 'No game registered yet' if @list_games.empty?
    puts "\n----- GAMES -----" unless @list_games.empty?
    @list_games.each_with_index.each do |e, i|
      author = "#{e.author.first_name} #{e.author.last_name}"
      prop_game = "Multiplayer: #{e.multiplayer}, Last played at: #{e.last_played_at}"
      puts "#{i + 1}) Publish date: #{e.publish_date}, Author: #{author}, #{prop_game}"
    end
  end

  def list_authors
    puts "\nNo author registered yet" if @list_authors.empty?
    puts "\n------ AVAILABLE AUTHORS ------" unless @list_authors.empty?
    @list_authors.each_with_index.each { |e, i| puts "#{i + 1}) #{e.first_name} #{e.last_name}" }
  end
end
