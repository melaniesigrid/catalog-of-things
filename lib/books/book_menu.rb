require 'json'
require 'fileutils'

require_relative 'book'
require_relative 'label'

class BookMenu
  def initialize
    @list_books = []
    @list_labels = []
    load_from_json
  end

  def add_book
    puts 'Add a new Book, please enter the publisher'
    publisher = gets.chomp.strip
    puts 'Would you like to archive it? Y/N'
    archived = gets.chomp.downcase == 'y'
    puts 'Is the state of the cover good or bad? Enter 1 for good and 2 for bad.'
    input = gets.chomp.strip
    cover_state = case input
                  when '1'
                    'good'
                  when '2'
                    'bad'
                  end
    puts 'Please enter the date it was published in the following format: YYYY-MM-DD'
    publish_date = gets.chomp.strip
    book = Book.new(publisher, cover_state, publish_date, archived)
    label = add_label
    label.add_item(book)
    puts 'Book created successfully!'
    @list_books << book
  end

  def add_label
    puts 'Create a label for your book, please enter the title.'
    title = gets.chomp.strip
    puts 'Please enter the label color'
    color = gets.chomp.strip
    label = Label.new(title, color)
    @list_labels << label
    puts 'Label created successfully!'
    label
  end

  def list_books
    @list_books.each do |book|
      puts "ID: #{book.id}   Publisher: #{book.publisher}
          Publication date: #{book.publish_date}
          Cover state: #{book.cover_state}"
    end
  end

  def list_labels
    @list_labels.each do |label|
      puts "ID: #{label.id}-) Title: #{label.title} Color: #{label.color}"
    end
  end

  def write_to_json
    collection = []
    @list_books.each do |book|
      collection.push({ label: book.label.title, label_color: book.label.color,
                        label_id: book.label.id, publisher: book.publisher,
                        cover_state: book.cover_state, publish_date: book.publish_date,
                        archived: book.archived, id: book.id })
    end
    FileUtils.touch('books.json') unless File.exist?('books.json')
    File.write('books.json', JSON.pretty_generate(collection))
  end

  def load_from_json
    return unless File.exist?('books.json')

    file = JSON.parse(File.read('books.json'))
    file.each do |data|
      book = Book.new(data['publisher'], data['cover_state'], data['publish_date'], data['archived'], id: data['id'])
      label = Label.new(data['label'], data['label_color'], id: data['label_id'])
      book.label = label
      label.add_item(book)
      @list_books.push(book)
      @list_labels.push(label)
    end
  end
end
