class Room
  attr_reader :name, :length, :width, :monster, :room_x, :room_y, :dropped_treasure
  attr_accessor :instances, :monster_status

  # List of all rooms created in dungeon
  @@instances = []

  #create a room in the dungeon with a name, size, a monster inside it, treasure guarded by the monster, and entry door position.
  def initialize(name, length_y, width_x, monster, monster_status = "alive")
    @name = name
    @room_x = width_x
    @room_y = length_y
    @monster = monster
    @monster_status = monster_status
    @dropped_treasure = []
    @@instances << self
    @dropped_treasure << treasure
    
  end

  def self.instances
    @@instances
  end

  def new_potion
    # creates a new potion
    Potion.new
  end

  def treasure
    # Adds a random treasure to the loot of the room
    treasure_choice = rand(10)
    case treasure_choice
    when 0..2
        drop = rand_weapon
    when 3..5
        drop = rand_defensive
    when 6..8
        drop = rand_boots
    else
        drop = new_potion
    end
  end

  def rand_weapon
    # selects a random item from the weapons list and removes it from the list

    Weapon.weapon_list.delete(Weapon.weapon_list.sample)
  end

  def rand_defensive
    # selects a random defensive item, either armor or a helmet
    [Helmet.helmet_list.delete(Helmet.helmet_list.sample), 
        Armor.armor_list.delete(Armor.armor_list.sample)].sample

  end

  def rand_boots
     # selects a random item from the boots list and removes it from the list
    Boots.boots_list.delete(Boots.boots_list.sample)
  end

end