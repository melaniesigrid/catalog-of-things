require 'json'
require 'fileutils'

require_relative 'book'
require_relative 'label'

module BookHelpers
  def self.write_to_json
    collection = []
    @list_books.each do |book|
      collection.push({ label: book.label.title, label_color: book.label.color, label_id: book.label.id, publisher: book.publisher,
                        cover_state: book.cover_state, published: book.publish_date, id: book.id, archived: book.archived })
    end
    FileUtils.touch('books.json') unless File.exist?('books.json')
    File.write('books.json', JSON.pretty_generate(collection))
  end

  def self.load_from_json
    return unless File.exist?('books.json')
    file = JSON.parse(File.read('books.json'))
    file.each do |data|
      book = Book.new(data['publisher'], data['cover_state'], data['publish_date'], data['id'], data['archived'])
      label = Label.new(data['label'], data['label_color'], data['label_id'])
      book.label = label;
      label.add_item(book)
      @list_books.push(book);
      @list_labels.push(label);
    end
  end

  def self.print_books
    @list_books.each do |book|
      puts "ID: #{book.id}-)  Publisher: #{book.publisher} Publication date: #{book.publish_date} Cover state: #{book.cover_state}"
    end
  end

  def self.print_labels
    @list_labels.each do |genre|
      puts "ID: #{label.id}-) Title: #{label.title} Color: #{label.color}"
    end
end