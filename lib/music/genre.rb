class Genre
  attr_accessor :name, :id, :items

  def initialize(name, id)
    @name = name
    @id = id
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end
end
