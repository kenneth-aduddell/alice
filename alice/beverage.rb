class Alice::Beverage

  include Mongoid::Document
  include Mongoid::Timestamps
  include Alice::Behavior::Searchable
  include Alice::Behavior::Tradeable

  field :name
  field :is_hidden, type: Boolean
  field :picked_up_at, type: DateTime

  validates_uniqueness_of :name

  belongs_to :user
  belongs_to :place

  attr_accessor :message

  def self.inventory_from(owner, list)
    return Alice::Util::Randomizer.empty_cooler if list.empty?
    return list.map(&:name_with_article).to_sentence
  end

  def self.total_inventory
    return "Someone needs to brew some drinks, we're dry!" if count == 0
    string = "Our beverage collection includes #{with_owner_names.to_sentence}."
    string << "Somewhere in the labyrinth you may find #{unclaimed.map(&:name_with_article).to_sentence}." if unclaimed.count > 0
    string
  end

  def self.sorted
    sort(&:name)
  end

  def self.with_owner_names
    all.sorted.map(&:owner).uniq.map(&:drinks)
  end

  def drink
    self.destroy
    message = Randomizer.drink_message
    message << Randomizer.effect_message if rand(3) == 1 
    message
  end

  def spill
    self.destroy && Randomizer.spill_message(self.name, owner)
  end

  def name_with_article
    Alice::Util::Sanitizer.process("a #{self.name}")
  end

end
