require_relative '../lib/books/book'
require_relative '../lib/books/label'
require 'json'

describe Book do
  before :all do
    @book1 = Book.new('Merriam-Webster Inc.', 'good', '2016-01-01', false, id: 1)
    label1 = Label.new('The Merriam-Webster Dictionary', 'blue', id: 1)
    @book1.label = label1
    @books_arr = [@book1]
    @labels_arr = [label1]
    File.write('spec/books.json', @books_arr.to_json)
  end

  before :each do
    @books_from_json = []
    if File.exist?('spec/books.json')
      @books_temp = JSON.parse(File.read('spec/books.json'))
      @books_temp.each do |obj|
        label_obj = @labels_arr.find { |label| label.id == obj['label_id'] }
        book = Book.new(obj['publisher'], obj['cover_state'], obj['publish_date'], obj['archived'], id: obj['id'])
        book.label = label_obj
        @books_from_json << book
      end
    end
  end

  context '#new' do
    it 'should create an instance of book' do
      expect(@book1).to be_instance_of(Book)
    end
  end

  describe '#load_data' do
    context 'from the books json file' do
      it 'should have one book' do
        expect(@books_from_json.length).to eql 1
      end
    end
  end
end