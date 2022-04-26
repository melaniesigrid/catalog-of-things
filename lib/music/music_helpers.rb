require 'json'
require 'fileutils'

module MusicHelpers
  def self.write_to_json
    collection = []
    @list_albums.each do |album|
      collection.push({ genre: album.genre.name, published: album.publish_date,
                        archived: album.archived, spotify: album.on_spotify, id: album.id })
    end
    FileUtils.touch('music.json') unless File.exist?('music.json')
    File.write('music.json', JSON.pretty_generate(collection))
  end

  def self.load_from_json
    return unless File.exist?('music.json')

    file = JSON.parse(File.read('music.json'))
    file.each do |data|
      album = MusicAlbum.new(data['published'], data['archived'],
                             data['spotify'], data['id'])
      genre = Genre.new(data['genre'])
      album.genre = genre
      genre.add_item(album)
      @list_album.push(album)
      @list_genre.push(genre)
    end
  end

  def self.print_albums
    @list_album.each do |album|
      puts "id: #{album.id}-)  publication date: #{album.publish_date} "
    end
  end

  def self.print_genres
    @list_genre.each do |genre|
      puts "id: #{genre.id}-) genre: #{genre.name} items: #{genre.items}"
    end
  end
end
