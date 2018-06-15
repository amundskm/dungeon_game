class Characters < Dungeon
end

class Adventurer < Characters
    attr_reader :name, :movement, :defense
    attr_accessor :weapon, :helmet, :armor, :boots, :position, :pack
  
    def initialize(name)
      @name = name
      @weapon = basic_sword
      @helmet = basic_helmet
      @armor = basic_armor
      @boots = basic_boots
      @position = [0,0]
      @pack = []
      @movement = @boots.movement
      @defense = @helmet.defense + @armor.defense
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
  
  end

class Monster < Dungeon
  attr_reader :name, :damage, :range, :movement, :health  

   def initialize(name, damage, range, movement, health)
     @name = name
-    @position = [0,0]
     @damage = damage
     @range = range
     @movement = movement
     @health = health
   end

 end