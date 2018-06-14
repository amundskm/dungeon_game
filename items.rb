class Monster < Dungeon
  attr_accessor :health
  attr_reader :name, :damage, :range, :movement

  def initialize(name, damage, range, movement, health)
    @name = name
    @damage = damage
    @range = range
    @movement = movement
    @health = health
  end

end

class Item < Dungeon
  def initialize
    @@number_of_items += 1
  end

end

class Weapon < Item
  attr_reader :name, :damage, :range, :weapon_list
  @@weapon_list = []
  def initialize(name, damage, range)
    @name = name
    @damage = damage
    @range = range
    @@weapon_list << @name
  end

  def self.weapon_list
    @@weapon_list
  end
  
end

class Defensive < Item
end

class Helmet < Defensive
  attr_reader :name, :defense, :helmet_list
  @@helmet_list = []
  def initialize(name, defense)
    @name = name
    @defense = defense
    @@helmet_list << @name
  end

  def self.helmet_list
    @@helmet_list
  end

end

class Armor < Defensive
  attr_reader :name, :defense, :armor_list
  @@armor_list = []
  def initialize(name, defense)
    @name = name
    @defense = defense
    @@armor_list << @name
  end

  def self.armor_list
    @@armor_list
  end

end

class Boots < Item
  attr_reader :name, :defense, :boots_list
  @@boots_list = []
  def initialize(name, movement)
    @name = name
    @movement= movement
    @@boots_list << @name
  end

  def self.boots_list
    @@boots_list
  end

end

class Potion < Item
  attr_reader :name
  @@number_of_potions = 0

  def initialize
    @name = "potion#{@@number_of_potions}"
    @@number_of_potions += 1
  end

  def potion_used
    @@number_of_potions -= 1
  end

end
