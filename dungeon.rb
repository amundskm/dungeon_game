class Dungeon
  @@number_of_rooms = 0
  @@number_of_items = 0

  def initialize
    # Created Monsters
    @hilgar = Monster.new("Hilgar the Hard", 5, 1, 2, 10)
    @bartheous = Monster.new("Bartheous the Barbarian", 3, 6, 1, 50)
    @cartus = Monster.new("Cartus the Camper", 25, 1, 5, 100)

    # Created Weapons
    @sword = Weapon.new("Super Sword", 10 , 1)
    @bow = Weapon.new("Bow of Slaying", 5 , 5)
    @knife = Weapon.new("Pointy Boy", 7 , 1)
    @basic_sword = Weapon.new("Basic Sword", 3, 1)

    # Created Helmets
    @leather_cap = Helmet.new("Leather Cap of Dunces", 3)
    @kettle_hat = Helmet.new("Kettle Hat of Cooking", 5)
    @frog_mouth = Helmet.new("Kermit's Headwear", 9)
    @basic_helmet = Helmet.new("Basic Helmet", 1)

    # Created Armor
    @leather_jerkin = Armor.new("Leather is Better than Nothing", 3)
    @chainmail = Armor.new("Chad's Chainmail", 5)
    @plate = Armor.new("Great Plate of Smiting", 15)
    @basic_armor = Armor.new("Basic Armor", 1)

    # Created Boots
    @moccasins = Boots.new("Sitting Bulls Shoes", 3)
    @hobnail = Boots.new("More Nail that Boot Boots", 5)
    @sabotons = Boots.new("Magic Sabatons", 10)
    @basic_boots = Boots.new("Basic Boots", 2)

    # Created Rooms
    @room1 = Room.new("Hallway", 10, 5, @hilgar, treasure)
    @room2 = Room.new("Laboratory", 20, 20, @bartheous, treasure)
    @room3 = Room.new("Kitchen", 30, 50, @cartus, treasure)

  end

  def treasure
    treasure_choice = rand(10.0)
    drop = rand_weapon if treasure_choice < 2
    drop = rand_defensive if (treasure_choice < 4) && (treasure_choice >= 2)
    drop = rand_boots if (treasure_choice < 6) && (treasure_choice >= 4)
    drop = new_potion if treasure_choice >= 6
  end

  def rand_weapon
    rand_item(Weapon.weapon_list)
  end

  def rand_defensive
    [rand_item(Helmet.helmet_list), rand_item(Armor.armor_list)].sample
  end

  def rand_boots
    rand_item(Boots.boots_list)
  end

  def new_potion
    Potion.new
  end

  def rand_item(item_list)
    item_length = item_list.length
    item_count = 0.0
    item_choice = rand(10.0)
    item_list.each do |item|
      item_count += 1
      if item_choice == (10.0 * item_count) / item_length
        return item_list
      end
    end
  end

end

class Gameplay < Dungeon

  # 1. enter room
  # 2. Decare room size, monster name, and monster health
  # 3. Ask for movement
  # 3.1 Check if move is valid
  # 3.2 If valid move to positon otherwise as for movement
  # 4. Declare attack
  # 5. Declare monster name, monster health
  # 6. If alive declare monster movement and damage
  # 6.1 If dead declare loot, move to 12
  # 7. Check Pack,  Move in Room, or go back to last room
  # 8 If Check Pack is selected declare options to inspect or use items in pack
  # 9. If Use potion selected, check for potion
  # 9.1 If no potion call 7
  # 9.2 If the adventurer has a potion in pack, add +25 health, delete 1 instance of potion
  # 10. If equip weapon is selected check for weapon in pack
  # 10.1 If no potion call 7
  # 10.2 if the adventurer has a weapon in pack equip it and move old weapon into pack
  # 11. Same options for Defensive equipment as 10
  # 12. Equip loot, Add to pack, or leave loot
  # 13. Add +50 hp to adventurer health for beating monster
  # 14. Ask to move to next room

end

class Adventurer < Dungeon
  attr_reader :name
  attr_accessor :equipped, :helmet, :armor, :boots, :position, :pack

  def initialize(name)
    @name = name
    @equipped = basic_sword
    @helmet = basic_helmet
    @armor = basic_armor
    @boots = basic_boots
    @position = [entryway, 0, 0]
    @pack = []
  end

end

class Room < Dungeon
  attr_reader :name, :length, :width, :monster
  attr_accessor :monster, :treasure

  def initialize(name, length, width, monster, treasure)
    @name = name
    @width = width
    @length = length
    @monster = monster
    @monster_status = true
    @treasure = treasure
    @@number_of_rooms += 1
  end

end

class Monster < Dungeon
  attr_accessor :health
  attr_reader :name, :damage, :range, :movement

  def initialize(name, damage, range, movement, health)
    @name = name
    @position = [0,0]
    @damage = damage
    @range = range
    @movement = movement
    @health = health
  end

  # somewhere in this mess I have to make the monster chase the adventurer
  # something with movement and position
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

Dungeon.new