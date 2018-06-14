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

  ## Starting the Game ##
  # 1. Create new adventurer
  def create_adventurer
    puts "What would you like your adventurer's name to be?(Max 13 characters) "
    adventurer_name = gets.chomp()
    while true
      if adventurer_name.length > 13
        puts "The name you entered is too long, please enter a shorter name: "
        adventurer_name = gets.chomp()
      else
        break
      end
    end

    Adventurer.new(adventurer_name)
  end

  # 2. Set Story
  def intro_story
    # Print out a lovely story to set the mood and explain gameplay.
  end
  #_______________________________________________________________________________________
  ## Running the Dungeon Rooms ##
  # 1. enter room
  def enter_room(room)
  # 2. Decare room size, monster name, and monster health
    puts "You have entered the #{room.name}. The room is #{room.length} long and  #{room.width} wide.
    You are at #{room.adventurer_x_position}, #{room.adventurer_y_position}.
    In the room, you see the monster #{room.monster.name} #{room.monster_status}.
    It is at #{room.monster_x_position}, #{room.monster_y_position} "
  end
  # 3. Ask for movement
  def player_movement(room, player)
    movement_left = player.movement
    
    #determine movement in x direction
    while true
      puts "Your current movement ability is #{player.movement}. You are currently at postiton x: 
      #{room.adventurer_x_position}, y:#{room.adventurer_y_position}  How far would you like to move in the
      x direction?"
      player_x_position = gets.chomp

      distance = abs(room.adventurer_x_position - player_x_position)

      if movement_left - distance < 0
        puts "You have exceeded your movement ability. Please try again."
      elsif (player_x_position < 0) || (player_x_position > room.room_x)
        puts "You have chosen a position outside the room. Please try again."
      else
        movement_left -= distance
        room.adventurer_x_position = player_x_position
        break
      end
    end

    # determine movement in y direction
    while true
      puts "Your current movement ability is #{movement_left}. You are currently at postiton x: 
      #{room.adventurer_x_position}, y:#{room.adventurer_y_position}  How far would you like to move in the
      y direction?"
      player_y_position = gets.chomp

      distance = abs(room.adventurer_y_position - player_y_position)

      if movement_left - distance < 0
        puts "You have exceeded your movement ability. Please try again."
      elsif (player_y_position < 0) || (player_y_position > room.room_y)
        puts "You have chosen a position outside the room. Please try again."
      else
        movement_left -= distance
        room.adventurer_y_position = player_y_position
        break
      end
    end
  end
      
  # 4. Declare attack
  def attack(room, player)
    distance_between = 

  # 5. Declare monster name, monster health
  def declare_monster
    puts "#{room.monster.name} has #{room.monster.health} hp."
  end
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
  #_______________________________________________________________________________________
  ## Finishing the Game ##
  # 1. print a fine story about finishing the game
end

class Adventurer < Dungeon
  attr_reader :name, :movement, :defense
  attr_accessor :equipped, :helmet, :armor, :boots, :position, :pack

  def initialize(name)
    @name = name
    @equipped = basic_sword
    @helmet = basic_helmet
    @armor = basic_armor
    @boots = basic_boots
    @position = [entryway, 0, 0]
    @pack = []
    @movement = @boots.movement
    @defense = @helmet.defense + @armor.defense
  end

end

class Room < Dungeon
  attr_reader :name, :length, :width, :monster
  attr_accessor :monster, :treasure, :instances, :monster_x_position, :monster_y_position
  instances = []
  def initialize(name, length, width, monster, treasure, door_x, door_y)
    @name = name
    @room_x = width
    @room_y = length
    @monster_x_position = rand(length)
    @monster_y_position = rand(width)
    @adventurer_x_position = door_x
    @adventurer_y_position = door_y
    @monster = monster
    @monster_status = "alive"
    @treasure = treasure
    @@number_of_rooms += 1
    @@instances << self
  end

  def self.all
    @@instances.inspect
  end

  def move_monster
    # move monster within striking distance if possible. Otherwise move max distance as close
    # to the adventurer as possible. # Something with stright line and triangles???
    monster_movement = @monster.movment
    monster_range = @monster.range

    # max straight line movement of monster in room
    @monster_y_position + monster_movement> room_y ? (max_move_y = room_y) : (max_move_y = @monster_y_position + monster_movement)
    @monster_y_position - monster_movement < 0 ? (min_move_y = 0) : (min_move_y = @monster_y_position - monster_movement)
    @monster_x_position + monster_movement > room_x ? (max_move_x = room_x) : (max_move_x = @monster_x_position + monster_movement)
    @monster_x_position - monster_movement < 0 ? (min_move_x = 0) : (min_move_x = @monster_x_position - monster_movement)

    # create array of x,y points that are avaiable to move to
    monster_movement_array = []
    (max_move_y - min_move_y).times do |y|
      (max_move_x - min_move_x).times do |x|
        length = (x ** 2 + y ** 2) ** (1 / 2) # < -- this might not be right but I am too tired to check it.
        if length < monster_movment
          monster_movement_array << [x,y] 
        end
      end
    end

    # max straight line range of monster in room
    @monster_y_position + monster_movement > room_y ? (max_range_y = room_y) : (max_range_y = @monster_y_position + monster_movement)
    @monster_y_position - monster_movement < 0 ? (min_range_y = 0) : (min_range_y = @monster_y_position - monster_movement)
    @monster_x_position + monster_movement > room_x ? (max_range_x = room_x) : (max_range_x = @monster_x_position + monster_movement)
    @monster_x_position - monster_movement < 0 ? (min_range_x = 0) : (min_range_x = @monster_x_position - monster_movement)

    # create array of x,y points that are avaiable to move to
    monster_range_array = []
    (max_range_y - min_range_y).times do |y|
      (max_range_x - min_range_x).times do |x|
        length = (x ** 2 + y ** 2) ** (1 / 2) # < -- this might not be right but I am too tired to check it.
        if length < monster_range
          monster_range_array << [x,y] 
        end
      end
    end

    # intersection of points available and point in range
    monster_intersection = monster_movement_array.select do |move_point|
      monster_range_array.any? {|range_point| range_point == move_point}
    end

    # if insersections is 0 set of closest points to target
    if monster_intersection == [] 
      min_distance = (monster_movement_array[0][0] ** 2 + monster_movement_array[0][1] ** 2) ** (1 / 2)
      monster_movement_array.each do |point| 
        distance = (point[0] ** 2 + point[1] ** 2) ** (1 / 2)
        if distance <= min_distance
          min_distance = distance
          monster_intersection << point
        end
      end
    end

    # return first option in set
    monster_intersection[0]
  end

  def move_adventurer
    # Get input from user on their x and y movement
    
    #check if x and y movement are valid inputs

    #posiiton adventurer at new position
  
  end

end

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

Dungeon.new