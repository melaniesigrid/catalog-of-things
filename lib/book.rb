require_relative './item'

class Book > Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, publish_date, id: random.rand(1..1000), archived: false)
    super(publish_date, id: id, archived: archived)
    @publisher = publisher
    @cover_state = cover_date
  end

  def can_be_archived?
    super || cover_state == 'bad'
  end
end
