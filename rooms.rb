class Room
  attr_reader :name, :length, :width, :monster, :room_x, :room_y
  attr_accessor :monster, :treasure, :instances, :monster_status

  # List of all rooms created in dungeon
  @@instances = []

  #create a room in the dungeon with a name, size, a monster inside it, treasure guarded by the monster, and entry door position.
  def initialize(name, length_y, width_x, monster, treasure, monster_status = "alive")
    @name = name
    @room_x = width_x
    @room_y = length_y
    @monster = monster
    @monster_status = monster_status
    @treasure = [treasure]
    @@instances << self
  end

  def self.instances
    @@instances
  end

end