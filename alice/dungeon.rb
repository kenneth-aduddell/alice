class Dungeon

  def self.reset!
    Actor.reset_all
    Item.reset_cursed
    Beverage.sweep
    Item.sweep
    Machine.sweep
    Place.delete_all
    Place.generate!(is_current: true)
    Item.create_defaults
    Item.deliver_fruitcake
    Actor::ensure_grue
    true
  end

  def self.win!
    User.award_points_to_active(5)
    Actor.grue.penalize(5)
  end

  def self.lose!
    User.award_points_to_active(-5)
    Actor.grue.score_points(5)
  end

end