require 'json'
require 'fileutils'

require_relative 'genre'
require_relative 'music_album'

class MusicMenu
  attr_accessor :list_genres, :list_albums

  def initialize
    @list_genres = []
    @list_albums = []
    load_json_files
  end

  def album_menu
    puts 'Add New Album'
    puts 'Publish Date: [YYYY-MM-DD]'
    date = gets.chomp
    puts 'Can be archived? [Y/N]'
    archived = gets.chomp.upcase
    puts 'On spotify? [Y/N]'
    spotify = gets.chomp.upcase
    album = MusicAlbum.new(date, archived, spotify)
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

  def print_albums
    @list_albums.each do |album|
      puts "ID: #{album.id}-) publication date: #{album.publish_date} "
    end
  end

  def print_genres
    @list_genres.each do |genre|
      puts "ID: #{genre.id}-) genre: #{genre.name}"
    end
  end

  def write_to_json
    arr = []
    @list_albums.each do |album|
      arr.push({ genre: album.genre.name, published: album.publish_date,
                 archived: album.archived, spotify: album.on_spotify, id: album.id })
    end
    FileUtils.touch('music.json') unless File.exist?('music.json')
    File.write('music.json', JSON.pretty_generate(arr))
  end

  def load_json_files
    return unless File.exist?('music.json')

    file = JSON.parse(File.read('music.json'))
    file.each do |data|
      album = MusicAlbum.new(data['published'], data['archived'],
                             data['spotify'], id: data['id'])
      genre = Genre.new(data['genre'])
      album.genre = genre
      genre.add_item(album)
      @list_albums.push(album)
      @list_genres.push(genre)
    end
  end
end
