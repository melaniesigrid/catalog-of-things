require_relative '../lib/music/genre'

describe Genre do
  before(:each) do
    @genre = Genre.new('Pop')
  end

  context 'Test GenreClass and its methods' do
    it '#new' do
      expect(@genre).to be_instance_of(Genre)
    end
  end

  it '#add_item' do
    expect(@genre.items).to be_empty
  end
end
