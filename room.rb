class Room
    attr_reader :name, :length, :width, :monster
    attr_accessor :monster, :treasure, :instances, :monster_x_position, :monster_y_position

    # List of all rooms created in dungeon
    instances = []

    #create a room in the dungeon with a name, size, a monster inside it, treasure guarded by the monster, and entry door position.
    def initialize(name, length_y, width_x, monster, treasure, door_x, door_y)
      @name = name
      @room_x = width_x
      @room_y = length_y
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
  end