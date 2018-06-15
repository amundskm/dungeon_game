
class Adventurer
  require "./items.rb"
  attr_reader :name, :movement, :defense
  attr_accessor :weapon, :helmet, :armor, :boots, :position, :pack , :health

  def initialize(weapon, helmet, armor, boots)
    @name = create_adventurer
    @weapon = weapon
    @helmet = helmet
    @armor = armor
    @boots = boots
    @position = [0,0]
    @pack = []
    @movement = @boots.movement
    @defense = @helmet.defense + @armor.defense
    @health = 100
  end

  def player_stats
    if pack == []
      packed = "#{name}'s pack is empty"
    else
      in_pack = ""
      pack.each {|item| in_pack = in_pack + "#{item.name}"}
      packed = "#{name}'s pack contains #{in_pack}"
    end
    puts "#{name} is at #{position[0]}, #{position[1]}. #{name} has the weapon #{weapon.name} equipped. It does
#{weapon.damage} damage and has a range of #{weapon.range}. #{name} has the #{helmet.name} helmet upon their head. It provides #{helmet.defense} 
defense. #{name} has the #{armor.name} strapped to their chest. It provides #{armor.defense} defense. And upon 
#{name}'s feet are the #{boots.name}. They give #{movement} movement. #{packed}

Total attack: #{weapon.damage}
Total defense: #{defense}
Total movement: #{movement}"
  end

  def add_to_pack(item)
    # if there are less than 4 things in the pack, add new item to pack
    if @pack.length <= 4
      @pack << item
    else
      puts "The pack is full. Remove something before adding to pack."
    end
  end

  def remove_from_pack(item)
    # returns the item deleted from pack or nil if item was not in pack
    if @pack.index(item)
      @pack.delete(item) 
    else
      puts "There is no item of that name in your pack."
    end
  end

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

    adventurer_name
  end

  def move_adventurer(room)
    room_x = room.room_x
    room_y = room.room_y
    # Get input from user on their x and y movement
    while true
        puts "Your total movement = #{movement}"
        puts "Please enter movement in the x and y direction: x,y"
        move = gets.chomp
        move_x = move.split(",")[0].to_i
        move_y = move.split(",")[1].to_i
        x = position[0]
        y = position[1]

        #check if x and y movement are valid inputs
        if (move_x < 0 || move_x > room_x)
            puts "You have eventered a point that is outside of the room. 
            Please try again" 
        end

        if (move_y < 0 || move_y > room_y)
            puts "You have eventered a point that is outside of the room. 
            Please try again" 
        end
        
        if (move_x - x).abs + (move_y - y).abs <= movement
            self.position = [move_x, move_y]
            break
        else
            puts "You have entered a point you cannot reach. Please try again."
        end
    end

  end

end

class Monster    
  include Math
  attr_reader :name, :damage, :range, :movement, :max_health
  attr_accessor :health, :position

  def initialize(name, damage, range, movement, health)
    @name = name
    @position = [0,0]
    @damage = damage
    @range = range
    @movement = movement
    @health = health
    @max_health = health
  end

  def move_monster(room, player)

    movement = self.movement
    movement = self.range
    mon_x = self.position[0]
    mon_y = self.position[1]
    room_x = room.room_x
    room_y = room.room_y
    adv_x = player.position[0]
    adv_y = player.position[1]
    # max straight line movement of monster in room
    mon_y + movement > room_y ? (max_move_y = room_y) : (max_move_y = mon_y + movement)
    mon_y - movement < 0 ? (min_move_y = 0) : (min_move_y = mon_y - movement)
    mon_x + movement > room_x ? (max_move_x = room_x) : (max_move_x =  mon_x + movement)
    mon_x - movement < 0 ? (min_move_x = 0) : (min_move_x =  mon_x - movement)


    # create array of x,y points that are avaiable to move to
    mon_arr = []
    min_dist = Math.sqrt((room_x) ** 2 + (room_y ** 2))
    min_dist_arr = [room_x, room_y]

    (min_move_y .. max_move_y).each do |y|
        (min_move_x .. max_move_x).each do |x|
            if (mon_x - x).abs + (mon_y - y).abs <= movement
                distance = Math.sqrt((adv_x - x) ** 2 + (adv_y - y) ** 2)
                if distance <= min_dist
                    min_dist = distance
                    min_dist_arr = [x,y]
                  end
                mon_arr << [x,y] if distance == range
            end
        end
    end


    if mon_arr == []

      self.position = min_dist_arr
      puts "The monster is NOT in range to attack."
      
    else
      puts "The monster is in range to attack."
      mon_attack(room, player)
       self.position = mon_arr[0]
    end
  end

  def mon_attack(room, player)
    # damage to player calculation
    attack = room.monster.damage
    player.health = attack - player.defense if attack > player.defense
    puts "#{player.name}'s health is at #{player.health}"
  end
 end