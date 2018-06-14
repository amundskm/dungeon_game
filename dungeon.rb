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

Dungeon.new