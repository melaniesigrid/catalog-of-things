require 'date'

class Item
  attr_accessor :id, :publish_date, :archived, :genre, :author, :label

  def initialize(id, publish_date, archived)
    @id = id
    @publish_date = publish_date
    @archived = archived
  end

  def can_be_archived?
    current_date = Date.today.year
    date = Date._parse(@publish_date)
    publish_year = current_year - date[:year]
    publish_year > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def author=(author)
    @author = author
    author.items << self unless author.items.include? self
  end
end
