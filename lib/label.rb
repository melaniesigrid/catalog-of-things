class Label
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title, color, id: random.rand(1..1000))
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
  end
end
