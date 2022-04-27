require_relative 'label'
require_relative 'book'
require_relative 'book_helpers'

class BookMenu
  include BookHelpers
  attr_accessor :list_books, :list_labels

  def initialize
    @list_books = []
    @list_labels = []
  end

  def add_book
    puts 'Add a new Book'
    puts 'What is the publisher?'
    publisher = gets.chomp.strip
    puts 'Is the state of the cover good or bad? Enter 1 for good and 2 for bad.'
    opt = {'1': 'good', '2': 'bad'}
    cover_state = opt[gets.chomp.strip]
    puts 'Please enter the date it was published in the following format: [YYY-MM-DD]'
    publish_date = gets.chomp.strip
    @list_books << Book.new(publisher, cover_state, publish_date)
    puts 'Book created successfully!'
    add_label
  end

  def add_label
    puts 'Create a label for your book, please enter the title.'
    title = gets.chomp.strip
    puts 'Please enter the label color'
    color = gets.chomp.strip
    @list_labels << Label.new(title, color)
    puts 'Label created successfully!'
  end

  BookHelpers.write_to_json

  BookHelpers.load_from_json

  BookHelpers.print_books

  BookHelpers.print_labels
end