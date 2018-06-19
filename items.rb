class Weapon
  attr_reader :name, :damage, :range, :weapon_list
  @@weapon_list = []
  def initialize(name, damage, range)
    @name = name
    @damage = damage
    @range = range
    @@weapon_list << self if (@name != "Empty") || (@name != "Basic Sword") 
  end

  def self.weapon_list
    @@weapon_list
  end
  
end

class Helmet
  attr_reader :name, :defense
  attr_accessor :helmet_list
  @@helmet_list = []
  def initialize(name, defense)
    @name = name
    @defense = defense
    @@helmet_list << self if (@name != "Empty") || (@name != "Basic Helmet") 
  end

  def self.helmet_list
    @@helmet_list
  end

end

class Armor
  attr_reader :name, :defense
  attr_accessor :armor_list
  @@armor_list = []
  def initialize(name, defense)
    @name = name
    @defense = defense
    @@armor_list << self if (@name != "Empty") || (@name != "Basic Armor") 
  end

  def self.armor_list
    @@armor_list
  end

end

class Boots
  attr_reader :name, :movement
  attr_accessor :boots_list
  @@boots_list = []
  def initialize(name, movement)
    @name = name
    @movement= movement
    @@boots_list << self if (@name != "Empty") || (@name != "Basic Boots") 
  end

  def self.boots_list
    @@boots_list
  end

end

class Potion
  attr_reader :name
  @@number_of_potions = 0

  def initialize
    @name = "potion#{@@number_of_potions}"
    @@number_of_potions += 1
  end


end
