class Vector
  attr_reader :x, :y, :z

  def initialize(x: 0, y: 0, z: 0)
    @x = x
    @y = y
    @z = z
  end

  def +(other)
    other_vector = other.is_a?(Vector) ? other : Vector.new(other) rescue nil
    raise "Can add only other Vector or Hash with keys x, y, z" unless other_vector
    @x += other_vector.x
    @y += other_vector.y
    @z += other_vector.z
    self
  end

end
