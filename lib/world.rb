require 'set'

class World < Identifiable
  def initialize
    super
    @spawns = {} # key: spawn identifier, value Living
    @positions = Hash.new # key: spawn identifier, value Position
    @occupiers = Hash.new([]) # key: Position, value Array of identifiers
  end

  def size=(size)
    @size = size.freeze
    @size_padding = @size.to_s.length
    @size
  end

  def level_map(max_height: @size)
    srand(@identifier.to_i(16))
    log("Generate level_map")
    log string_map
    high_points = @size / 2 
    log("Will put #{high_points} high points")
    high_points.times do 
      height = rand(max_height)
      point = rand(@size) * rand(@size)
      @level_map[point] = height
    end
    log string_map
  end

  def string_map(with_grid: true)
    map = "\n\n"
    if with_grid
      map << " " * (1 + @size_padding)
      map << (0..@size-1).map do |index|
        "%0#{@size_padding}d" % index
      end.join(' ')
      map << "\n"
    end
    @level_map.each_with_index do |level, index|
      end_of_line = (index+1) % @size == 0
      if with_grid && index % @size == 0
        map << "%0#{@size_padding}d " % (index / @size)
      end
      map << "%0#{@size_padding}d" % level
      if end_of_line
        map << "\n" 
      else
        map << ','
      end
    end
    map
  end

  def spawn(klass)
    item = klass.new
    @spawns[item.identifier] = item
    pos = random_free_position
    @positions[item.identifier] = pos
    @occupiers[pos] << item.identifier
    log("Spawned #{item.identify} at #{pos}")
  end

  def setup(living_count: 3)
    @level_map = Array.new(@size**2, 0)
    level_map
    living_count.times do
      spawn(Living)
    end
  end

  def run_tick
    log("World tick")
    log("Spawns turn")
    @spawns.values.each do |spawn|
      spawn.run_tick({pos: @positions[spawn.identifier]})
    end
  end

  def random_free_position
    pos = nil
    loop do
      pos = Position.new(rand(@size), rand(@size), rand(@size))
      break unless @occupiers.keys.include?(pos)
    end
    pos
  end
end
