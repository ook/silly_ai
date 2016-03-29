class Position
  include Comparable

  def x
    @x
  end

  def y
    @y
  end

  def z
    @z
  end

  def z=(new_z)
    @z = new_z
  end

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def <=>(other)
    return 0 if x == other.x && y == other.y && z == other.z
    return x <=> other.x if x != other.x
    return y <=> other.y if y != other.y
    return z <=> other.z if z != other.z
  end

  def to_s
    "x=#{@x},y=#{@y},z=#{@z}"
  end
end
