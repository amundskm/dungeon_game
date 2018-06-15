class Dungeon
  %w{./characters.rb ./items.rb ./rooms.rb}.each { |l| require l }
  include Math
  attr_reader :room0, :room1, :room2, :room3, :player
  attr_accessor  :current_room

  def initialize
    # Created Monsters
    @hilgar = Monster.new("Hilgar the Hard", 5, 1, 3, 6)
    @bartheous = Monster.new("Bartheous the Barbarian", 3, 6, 1, 50)
    @cartus = Monster.new("Cartus the Camper", 25, 1, 5, 100)

    # Created Weapons
    @sword = Weapon.new("Super Sword", 10 , 1.0)
    @bow = Weapon.new("Bow of Slaying", 5 , 5.0)
    @knife = Weapon.new("Pointy Boy", 7 , 1.0)
    @basic_sword = Weapon.new("Basic Sword", 3, 1.0)

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
    @room0 = Room.new("Entryway", 3, 3, false, false, "dead")
    @room1 = Room.new("Hallway", 6, 3, @hilgar, treasure)
    @room2 = Room.new("Laboratory", 10, 10, @bartheous, treasure)
    @room3 = Room.new("Kitchen", 20, 11, @cartus, treasure)
    @room4 = Room.new("Exit", 3, 3, false, false, "dead")

    #create Adventurer
    @player = Adventurer.new(@basic_sword, @basic_helmet, @basic_armor, @basic_boots)
    #starting room
    @current_room = @room0

    mon_pos

  end

  def mon_pos

    Room.instances.each do |room|
      if room.monster != false
        room.monster.position = [rand(room.room_x), rand(room.room_y)]
      end
    end
  end

  def treasure
    # Adds a random treasure to the loot of the room
    treasure_choice = rand(10.0)
    drop = rand_weapon if treasure_choice < 2
    drop = rand_defensive if (treasure_choice < 4) && (treasure_choice >= 2)
    drop = rand_boots if (treasure_choice < 6) && (treasure_choice >= 4)
    drop = new_potion if treasure_choice >= 6
  end

  def rand_weapon
    # selects a random item from the weapons list and removes it from the list
    Weapon.weapon_list.delete(rand_item(Weapon.weapon_list))
  end

  def rand_defensive
    # selects a random defensive item, either armor or a helmet
    [Helmet.helmet_list.delete(rand_item(Helmet.helmet_list)), Armor.armor_list.delete(rand_item(Armor.armor_list))].sample
  end

  def rand_boots
     # selects a random item from the boots list and removes it from the list
    Boots.boots_list.delete(rand_item(Boots.boots_list))
  end

  def new_potion
    # creates a new potion
    Potion.new
  end

  def rand_item(item_list)
    # item randomizer
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

  def use_potion
    # adds health to a players hp and deletes the potion
    if player.pack.index(potion)
      if @health < 75
          @health += 25
      else
          @health = 100
      end
      player.pack.delete(potion)
    else
      puts "There are no potions in the pack."
    end
  end

  def in_range(adv_pos, mon_pos)
    # determines if the player is in range of the monster to attack
    distance = Math.sqrt((adv_pos[0] - mon_pos[0]) ** 2 + (adv_pos[1] - mon_pos[1]) ** 2)
  end

  def attack_options(room)
    # gives option to attack or retreat. If attack is chosen, determines if player is in range.
    # if retreat is chosen, moves to the previous room
    while true
      puts "Would you like to attack or retreat?"
      choice = gets.chomp
      case choice
      when "attack"
        draw_room(room, player)
        player.move_adventurer( room)
        range = in_range(player.position, room.monster.position)
        puts "#{range}, #{player.weapon.range}"
        if range <= player.weapon.range
          adv_attack(room)
        else
          puts "You are not in range"
        end

        room.monster.move_monster(room, player)

        draw_room(room, player)
        room
        break
      when "retreat"
        room = retreat(room)
        break
      else
        puts "That is not a valid option. Please enter your choice to attack or retreat."
      end
    end
    room
  end

  def retreat(room)
    if room.monster != false
      if room.monster_status = "alive"
        room.monster.health = room.monster.max_health 
      end
    end
    new_room = Room.instances.index(room) - 1
    new_room = 0 if new_room < 0
    Room.instances[new_room]
  end

  def adv_attack(room)
    # damage to monster calcualtion
    attack = @player.weapon.damage
    room.monster.health -= attack
    post_adv_attack(room)
    room
  end

  def post_adv_attack(room)
    # determines monster health
    if room.monster.health <= 0
      room.monster_status = "dead"
    else
      puts "#{room.monster.name} is at #{room.monster.health} health."
    end
  end

  def enter_room(room)
    # states current room, monster name, and positionn of monster in the room.
    if room.monster == false
      puts "You are in safe in #{room.name}. There are no monsters."
    else
      puts "As you enter the #{room.name}, you see #{room.monster.name} standing at #{room.monster.position[0]},  #{room.monster.position[0]}. 
it is #{room.monster_status}. The room is #{room.room_x} by #{room.room_y}"

      draw_room(room, player)
    end
  end

  def draw_room(room, player )

    puts "#{room.name}: "
    puts "   0"
    puts "   |"
    puts "   v"
    room.room_x.times do |x|
        
        if x == 0
            print "0->"   
        else
            print "   "
        end
        room.room_y.times do |y|
            if (x == player.position[0]) && (y == player.position[1])
                print "A  " 
            elsif (x == room.monster.position[0]) && (y == room.monster.position[1])
                print "M  "
            else
                print "*  "
            end
        end
    puts ""
    end

        puts "The room is #{room.room_x} wide by #{room.room_y} long.
    You are at point #{player.position[0]}, #{player.position[1]}.
    The monster is at point #{room.monster.position[0]}, #{room.monster.position[1]}."
  end

  def staging(room)
    # Determine how the player wants to move between rooms
    while true
      puts "What would you like to do? [continue, retreat, see_stats, loot, open_pack]"
      ans = gets.chomp
      case ans
      when "continue"
        new_room = Room.instances.index(room) + 1
        new_room = 0 if new_room < 0
        room = Room.instances[new_room]
        break
      when "see_stats"
        player.player_stats
        room
      when "retreat"
       room = retreat(room)
        break
      when "loot"
          loot()
          room
        break
      when "open_pack"
        open_pack(room)
        room
        break
      else
        puts "That is not a valid selection."
      end
    end

    room
  end


  def open_pack(room)

    while true
      puts "In #{player.name}'s pack there is: "
      player.pack.each { |item| puts "#{item.name} "}

      puts "What would you like to do with your pack? [drop_item, equip_item, pack_item, use_potion, close_pack]"
      ans = gets.chomp

      case ans
      when "drop_item"
        puts "What item would you like to drop?"
        input = gets.chomp
        player.pack.each do |item|
          if item.name == input
            room.treasure << player.pack.delete(input.to_s) 
            puts "#{item.name} has been droppin on the ground."
          end
        end
       when "equip_item"
         puts "What item would you like to equip?"
         input = gets.chomp
         player.pack.each do |item|
          if item.name == input
            if item.is_a?(Weapon)
              player.weapon = player.pack.delete(item)
            elsif item.is_a(Helmet)
              player.helmet = player.pack.delete(item)
            elsif item.is_a(Armor)
              player.armor = player.pack.delete(item)
            elsif item.is_a(Boots)
              player.boots = player.pack.delete(item)
            end
          end
        end
       when "use_potion"
        player.pack.each do |item|
          if item.is_a?(Potion)
            player.pack.delete(item)
            if player.health >= 75
              player.health = 100
            else
             player.health += 25
            end
            puts "A potion has been used. #{player.name}'s current health is #{player.health}."
          end
        end
      when "pack_item"
        puts "Which item would you like to pack?"
        room.treasure.each do |item|
          puts "From loot on floor: #{item.name}"
        end
        puts "#{player.weapon}"
        puts "#{player.helmet}"
        puts "#{player.armor}"
        puts "#{player.boots}"
        input = gets.chomp
        room.treasure.each do |item|
          if input == item.name
            player.pack << room.treasure.delete(item)
          end
        end
       when "close_pack"
         break
      else
        puts "That is not a valid response."
      end
    end
  end

  def loot(room)
    while true
      puts "On the floor you find: #{room.treasure}. What would you like to do? [equip_item, put_in_pack, nothing]"
      input = gets.chomp
      case input
      when 

  def intro(player)
    # introduction to the game
    puts "lots and lots of good stuff"
  end

  def conclusion(player)
    puts "the end"
  end
end

def main(game)

  player = game.player

  game.intro(player)
  old_room = game.current_room
  while  Room.instances.index(game.current_room) < Room.instances.length do
    if old_room != game.current_room
      game.enter_room(game.current_room)
      old_room = game.current_room
    end

    if game.current_room.monster_status == "dead"
      game.current_room = game.staging(game.current_room)
    else
      game.current_room = game.attack_options(game.current_room)
    end
  end

  game.conclusion(player)


end 

gameplay = Dungeon.new
main(gameplay)