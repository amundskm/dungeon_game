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