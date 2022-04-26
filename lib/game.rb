require_relative './item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at, publish_date, id: Random.rand(1..1000), archived: false)
    super(publish_date, id: id, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    years_from_last_played = Date.new.year.to_i - @last_played_at.slice(0, 4).to_i
    super && years_from_last_played > 2
  end
end
