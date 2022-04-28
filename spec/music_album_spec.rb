require_relative '../lib/music/music_album'

describe MusicAlbum do
  before(:each) do
    @album = MusicAlbum.new('2022/04/27', true, true)
  end

  context 'Test AlbumClass and its methods' do
    it '#new' do
      expect(@album).to be_instance_of(MusicAlbum)
    end
  end

  it 'expect can_be_archive? method return true' do
    expect(@album.can_be_archived?).to be(false)
  end
end
