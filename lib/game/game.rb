require_relative '../item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at, publish_date, archived: false, id: Random.rand(1..1000))
    super(publish_date, archived, id)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    years_from_last_played = Date.new.year.to_i - @last_played_at.slice(0, 4).to_i
    super && years_from_last_played > 2
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'multiplayer' => @multiplayer,
      'last_played_at' => @last_played_at,
      'publish_date' => @publish_date,
      'archived' => @archived,
      'author' => @author.id
    }.to_json(*args)
  end
end
