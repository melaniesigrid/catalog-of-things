require_relative '../lib/game/author'
require 'json'

describe Author do
  before :all do
    @authors_arr = [Author.new('Douglas', 'Crockfour'), Author.new('Jeffrey', 'Zeldman')]
    File.write('spec/authors.json', JSON.generate(@authors_arr))
  end

  before :each do
    @authors = []
    if File.exist?('spec/authors.json')
      authors_temp = JSON.parse(File.read('spec/authors.json'))
      authors_temp.each do |author|
        @authors << Author.new(author['first_name'], author['last_name'])
      end
    end
  end

  context '#load_data method' do
    it 'should has 2 Authors' do
      expect(@authors.length).to eql 2
    end
  end

  describe '#new method' do
    context 'with no parameters' do
      it 'throws an argument error' do
        expect { Author.new }.to raise_exception ArgumentError
      end
    end

    context 'with two parameters' do
      it 'is an instance of the Author class' do
        expect(Author.new('firs name', 'last name')).to be_an_instance_of Author
      end
    end
  end

  describe '#Get' do
    context 'author first name' do
      it 'returns the correct author first name' do
        expect(@authors_arr[0].first_name).to eql 'Douglas'
      end
    end

    context 'author last name' do
      it 'returns the correct author last name' do
        expect(@authors_arr[1].last_name).to eql 'Zeldman'
      end
    end
  end
end
