# There are three methods and the "main" execution at the bottom to do.
# I have marked the locations to fill in with TODO tags.
# I recommend tackling these in order - I have numbered them in the
# order I recommend working on them.
# Remember you can use irb to test out your methods and try out syntax!

# Print the array to the screen, with x representing a living
# cell and . representing a dead cell.
# Finish the printing with a single line of asterisks, exactly
# as long as the array is wide.
# There is no need to return anything
# Example:
# ...........
# ...........
# ...........
# ...........
# ...........
# ...........
# .........x.
# ........x.x
# .......x..x
# ........xx.
# ...........
# ***********

def print_arr(arr)
  # TODO 1
  (0...arr.count).each do |x|
    (0...arr[x].count).each do |y|
      if(arr[x][y])
        print 'X'
      else
        print '.'
      end
    end
    puts
  end
  nil
end

# Should return the # of living neighbors of cell in location x, y
# in array arr (i.e., this will return a value between 0 - no living
# neighbors and 8 - every cell around this cell is living)

def num_neighbors(x, y, arr)
  # TODO 2
  count = 0
  if(arr[(x-1)%arr.count][(y-1)%arr[0].count])
    count += 1
  end
  if(arr[(x-1)%arr.count][y])
    count += 1
  end
  if(arr[(x-1)%arr.count][(y+1)%arr[0].count])
    count += 1
  end
  if(arr[x][(y-1)%arr[0].count])
    count += 1
  end
  if(arr[x][(y+1)%arr[0].count])
    count += 1
  end
  if(arr[(x+1)%arr.count][(y-1)%arr[0].count])
    count += 1
  end
  if(arr[(x+1)%arr.count][y])
    count += 1
  end
  if(arr[(x+1)%arr.count][(y+1)%arr[0].count])
    count += 1
  end
  count
end

# Should perform one iteration of Conway's game of life, as
# described in exercise1.md

def iterate(arr)
  # TODO 3
  temp = []
  (0...arr.count).each do |x|
    temp[x] = [x]
    (0...arr[x].count).each do |y|
      neighbors = num_neighbors(x, y, arr)
      if(neighbors == 3)
        temp[x][y] = true
      elsif(arr[x][y] && neighbors == 2)
        temp[x][y] = true
      else
        temp[x][y] = false
      end
    end
  end
  temp
end

# Given a pseudorandom number generator, a size, and a percentage
# of cells to be alive, make a size x size array (e.g., a 10 x 10 array
# if size = 10), and randomly assign percent % of them to be living.
# Return the newly created array to the caller.

def create_arr(prng, size, percent)
  arr = []
  (0...size).each do |x|
    arr[x] = []
    (0...size).each do |y|
      arr[x][y] = prng.rand(101) <= percent
    end
  end
  arr
end


# EXECUTION STARTS HERE

# TODO 4

raise "Enter integers for size, percentage (1..100), and number of iterations at command line" unless ARGV.count == 3
size, percent, iters = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i

# All of these can be done
# If size is not >0, inform the user and exit
# If percent is not an integer between 0 and 100, inform the user and exit
# If number of iterations is not an integer that is 0 or greater, inform the user and exit
prng = Random.new


#array is predefined as an oscillator - will ignore percentage passed unless this is changed

# Create the array and assign it a new array from the create_array method
arr = create_arr(prng, size, percent)

# Iterate for _iters_ iterations
print_arr(arr)
(0...iters).each do |x|
  arr = iterate(arr)
  puts
  puts "Iteration #{x+1}"
  print_arr(arr)
end