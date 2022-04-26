require_relative 'author'
require_relative 'game'
require_relative 'game_helpers'
require 'json'

class GameApp
  include GameHelpers

  def initialize
    @list_authors = []
    @list_games = []
  end

  def add_game
    puts 'Add New Game'
    print "\nPublish date (yyyy/mm/dd): "
    publish_date = validates_date
    print 'Multiplayer (y/n): '
    multiplayer = gets.chomp.to_s
    multiplayer = multiplayer.downcase == 'y'
    print 'Last played at (yyyy/mm/dd): '
    last_played_at = validates_date
    game = Game.new(multiplayer, last_played_at, publish_date)
    game.author = select_author
    @list_games << game
    puts "Game created successfully\n\n"
  end

  def add_author
    print 'First name: '
    first_name = gets.chomp.to_s
    print 'Last name: '
    last_name = gets.chomp.to_s
    @list_authors << Author.new(first_name, last_name)
    @list_authors[-1]
  end

  def select_valid_author_option(option, start, endi)
    until option == 'n' || (option.to_i >= start && option.to_i <= endi)
      print 'Please enter a valid option: '
      option = gets.chomp.strip.downcase
    end
    option
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
end
