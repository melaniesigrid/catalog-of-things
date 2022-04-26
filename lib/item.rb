require 'date'

class Item
  attr_accessor :genre, :label
  attr_reader :publish_date, :author

  def initialize(publish_date, id: Random.rand(1..1000), archived: false)
    @id = id
    @publish_date = publish_date
    @archived = archived
  end

  def can_be_archived?
    current_date = Date.today.year.to_i
    year = @publish_date.slice(0, 4).to_i
    current_date - year > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def author=(author)
    @author = author
    author.items << self unless author.items.include? self
  end
end
