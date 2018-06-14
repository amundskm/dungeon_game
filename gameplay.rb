class Gameplay < Dungeon

    ## Starting the Game ##
    # 1. Set Story
    def intro_story
      # Print out a lovely story to set the mood and explain gameplay.
    end

    # 2. Create new adventurer
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
  
    # 1. enter room
    # 2. Decare room size, monster name, and monster health
    # 3. Ask for movement
      #determine movement in x direction
      # determine movement in y direction
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
    #_______________________________________________________________________________________
    ## Finishing the Game ##
    # 1. print a fine story about finishing the game
  end