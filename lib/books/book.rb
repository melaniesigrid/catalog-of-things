require_relative '../item'

class Book < Item
  attr_accessor :publisher, :cover_state, :publish_date, :archived

  def initialize(publisher, cover_state, publish_date, archived, id: rand(1..1000))
    super(publish_date, archived, id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || cover_state == 'bad'
  end
end
