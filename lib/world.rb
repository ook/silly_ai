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
