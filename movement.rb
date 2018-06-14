def move_monster(movement, range, mon_x, mon_y, adv_x, adv_y, room_x, room_y)
    include Math

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
            mon_arr << [x,y] if distance == range
            end
        end
      end
    end

    if mon_arr == []
        puts "not in range"
        return min_dist_arr
    else
        puts "in range @: "
        return mon_arr[0]
    end

end


def move_adventurer(adv_x, adv_y, movement, room_x, room_y)
    # Get input from user on their x and y movement
    while true
        puts "Please enter movement in the x direction: "
        move_x = gets.chomp
        puts "Please enter movement in the y direction: "
        move_y = gets.chomp

        #check if x and y movement are valid inputs
        if (mon_x < 0 || mon_x > room_x)
            puts "You have eventered a point that is outside of the room. 
            Please try again" 
        end
        if (mon_y < 0 || mon_x > room_y)
            puts "You have eventered a point that is outside of the room. 
            Please try again" 
        end
        if (mon_x - x).abs + (mon_y - y).abs <= movement
            [x,y]
            break
        else
            puts "You have entered a point you cannot reach. Please try again."
        end       
  end
end

