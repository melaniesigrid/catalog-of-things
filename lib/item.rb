require 'date'

class Item
  attr_accessor :genre, :label, :author

  def initialize(id, publish_date, _archived)
    @id = id
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    current_date = Date.today.year.to_i
    year = @publish_date.slice(0, 4).to_i
    current_date - year > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
