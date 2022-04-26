require_relative '../helpers/validations'
require_relative './game/author'
require_relative './game/game'
require_relative './game/game_manager'
require 'json'

class App
  include Validations
  include GameAuthorManager

  def initialize
    @authors = []
    @games = []
  end

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

  def add_game
    print "\nPublish date (yyyy/mm/dd): "
    publish_date = validates_date
    print 'Multiplayer (y/n): '
    multiplayer = gets.chomp.to_s
    multiplayer = multiplayer.downcase == 'y'
    print 'Last played at (yyyy/mm/dd): '
    last_played_at = validates_date
    game = Game.new(multiplayer, last_played_at, publish_date)
    game.author = select_author
    @games << game
    puts "Game created successfully\n\n"
  end

  def list_games
    puts 'No game registered yet' if @games.empty?
    puts "\n----- GAMES -----" unless @games.empty?
    @games.each_with_index.each do |e, i|
      author = "#{e.author.first_name} #{e.author.last_name}"
      prop_game = "Multiplayer: #{e.multiplayer}, Last played at: #{e.last_played_at}"
      puts "#{i}) Publish date: #{e.publish_date}, Author: #{author}, #{prop_game}"
    end
  end

  def list_authors
    puts 'No author registered yet' if @authors.empty?
    puts "\n------ AVAILABLE AUTHORS ------" unless @authors.empty?
    @authors.each_with_index.each { |e, i| puts "#{i}) #{e.first_name} #{e.last_name}" }
    puts
  end

  def store_data
    File.write('data/authors.json', JSON.generate(@authors))
    File.write('data/games.json', JSON.generate(@games))
  end
end
