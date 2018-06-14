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