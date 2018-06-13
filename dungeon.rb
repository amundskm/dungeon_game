class Dungeon
  @@number_of_rooms = 0
  @@number_of_items = 0
end

class Adventurer < Dungeon
  attr_reader :name
  attr_accessor :equipped, :helmet, :armor, :boots, :position, :pack

  def initialize(name)
    @name = name
    @equipped = basic_sword
    @helmet = basic_helment
    @armor = basic_armor
    @boots = basic_boots
    @position = [entryway, 0, 0]
    @pack = []
  end

end

class Room < Dungeon
  attr_reader :name, :length, :width, :monster
  attr_accessor :monster, :treasure

  def intialize(name, length, width, monster, treasure)
    @name = name
    @width = width
    @length = length
    @monster = monster
    @monster_status = true
    @treasure = treasure
  end

end

class Monster < Dungeon
  attr_accessor :health
  attr_reader :name, :damage, :range, :movement

  def initialize(name, damage, range, movement, health)
    @name = name
    @position = [room, random_position]
    @damage = damage
    @range = range
    @movement = movement
    @health = health
  end

  # somewhere in this mess I have to make the monster chase the adventurer
  # something with movement and position
end

class Item < Dungeon

  def create_item()
    # 25% of the time the item is a potion,
    # 25% of the time the item is a weapon
    # 35% of the time the item is Defenstive
    # 15% of the time the item is boots
  end
end

class Weapon < Item
  attr_reader :name, :damage, :range

  def initialize(name, damage, range)
    @name = name
    @damage = damage
    @range = range
  end
end

class Defensive < Item
  attr_reader :name, :defense

  def create_Defensive()
  # 50% of the time the Defensive is a helmet
  # 50% of the time the Defensive is an armor
  end
end

class Helmet < Defensive
  attr_reader :name, :defense

  def initialize(name, defense)
    @name = name
    @defense = defense
  end
end

class Armor < Defensive
  attr_reader :name, :defense

  def initialize(name, defense)
    @name = name
    @defense = defense
  end
end

class Boots < Item
  attr_reader :name, :defense

  def intialize(name, movement)
    @name = name
    @defense = defense
  end
end
 
