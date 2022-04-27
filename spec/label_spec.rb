require_relative '../lib/books/label'
require 'json'

describe Label do
  before :all do
    @labels_arr = [Label.new('The Merriam-Webster Dictionary', 'blue', id: 1), Label.new('Harry Potter', 'red', id: 2)]
    File.write('spec/labels.json', JSON.generate(@labels_arr))
  end

  before :each do
    @labels = []
    if File.exist?('spec/labels.json')
      labels_temp = JSON.parse(File.read('spec/labels.json'))
      labels_temp.each do |label|
        @labels << Label.new(label['label'], label['label_color'], id: label['label_id'])
      end
    end
  end

  context '#load_data method' do
    it 'should have 2 labels' do
      expect(@labels.length).to eql 2
    end
  end

  describe '#new method' do
    context 'with no parameters' do
      it 'throws an argument error' do
        expect { Label.new }.to raise_exception ArgumentError
      end
    end

    context 'with the correct parameters' do
      it 'is an instance of the Label class' do
        expect(Label.new('My Little Pony', 'pink', id: 3)).to be_an_instance_of Label
      end
    end
  end
end
