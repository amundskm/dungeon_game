class Characters < Dungeon
end

class Adventurer < Characters
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