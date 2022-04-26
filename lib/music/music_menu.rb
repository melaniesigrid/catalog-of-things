require_relative 'genre'
require_relative 'music_album'
require_relative 'music_helpers'

class MusicApp
  include MusicHelpers
  attr_accessor :list_genres, :list_albums

  def initialize
    @list_genres = []
    @list_albums = []
  end

  def album_menu
    puts 'Add New Album'
    puts 'Publish Date: [YYYY-MM-DD]'
    date = gets.chomp
    puts 'Can be archived? [Y/N]'
    archived = gets.chomp.upcase
    puts 'On spotify? [Y/N]'
    spotify = gets.chomp.upcase
    album = MusicAlbum.new(album_name, date, archived, spotify)
    genre = genre_menu
    genre.add_item(album)
    puts 'Album created succesfully'
    @list_albums << album
  end

  def genre_menu
    puts "Add Genre\n\n"
    puts 'Genre name:'
    genre_name = gets.chomp
    genre = Genre.new(genre_name)
    @list_genres << genre
    genre
  end

  MusicHelpers.write_to_json

  MusicHelpers.load_from_json

  MusicHelpers.print_albums

  MusicHelpers.print_genres
end
