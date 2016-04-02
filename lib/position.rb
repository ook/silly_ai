class Position
  include Comparable

  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def <=>(other)
    return 0 if @x == other.x && @y == other.y && @z == other.z
    return @x <=> other.x if @x != other.x
    return @y <=> other.y if @y != other.y
    return @z <=> other.z if @z != other.z
  end

  def +(vector)
    sure_vector = vector.is_a?(Vector) ? vector : Vector.new(vector) rescue nil
    raise "Can add only Vector instance or Hash with keys x, y, z" unless sure_vector
    Position.new(@x + sure_vector.x, @y + sure_vector.y, @z + sure_vector.z)
  end

  def to_s
    "x=#{@x},y=#{@y},z=#{@z}"
  end
end
