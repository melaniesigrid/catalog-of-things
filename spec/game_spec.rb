require_relative '../lib/game/author'
require_relative '../lib/game/game'
require 'json'

describe Game do
  before :all do
    author1 = Author.new('Douglas', 'Crockfour')
    author2 = Author.new('Jeffrey', 'Zeldman')
    @authors_arr = [author1, author2]

    game1 = Game.new(true, '2020/01/01', '2019/01/01')
    game1.author = author1
    game2 = Game.new(false, '2022/01/01', '2020/01/01')
    game2.author = author2
    game3 = Game.new(true, '2022/01/01', '2021/01/01')
    game3.author = author2
    @games_arr = [game1, game2, game3]

    File.write('spec/games.json', @games_arr.to_json)
  end

  before :each do
    @games_from_json = []
    if File.exist?('spec/games.json')
      @games_temp = JSON.parse(File.read('spec/games.json'))
      @games_temp.each do |obj|
        author_obj = @authors_arr.find { |author| author.id == obj['author'] }
        game = Game.new(obj['multiplayer'], obj['last_played_at'], obj['publish_date'])
        game.author = author_obj
        @games_from_json << game
      end
    end
  end

  describe '#load_data' do
    context 'from a json file' do
      it 'should has three games' do
        expect(@games_from_json.length).to eql 3
      end
    end
  end

  describe '#new' do
    context 'with no parameters' do
      it 'should throw an Argument Error' do
        expect { Game.new }.to raise_exception ArgumentError
      end
    end

    context 'with parameters' do
      it 'should be an instance of game class' do
        expect(@games_arr[0]).to be_an_instance_of Game
      end
    end
  end

  describe '#Get' do
    context 'date' do
      it 'should return the correct publish date for the first game' do
        expect(@games_from_json[0].publish_date).to eql '2019/01/01'
      end

      it 'should return the correct last played date for the second game' do
        expect(@games_from_json[1].last_played_at).to eql '2022/01/01'
      end
    end

    context 'author' do
      it 'should return the correct author name for the third game' do
        author_name = "#{@games_from_json[1].author.first_name} #{@games_from_json[1].author.last_name}"
        expect(author_name).to eql 'Jeffrey Zeldman'
      end
    end
  end
end
