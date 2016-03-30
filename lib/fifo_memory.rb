class FifoMemory

  def initialize(size = 16)
    @mem = []
    @max_size = size
  end

  def push(elem, only_if_different: true)
    return self if only_if_different && elem == see
    @mem.pop if @mem.length == @max_size
    @mem.insert(0, elem)
    self
  end

  def pop(count = 1)
    values = @mem.take(count)
    @mem.drop(count)
    values
  end

  def see
    @mem[0]
  end

  def to_s
    "@max_size=#{@max_size} @mem=#{@mem.inspect}"
  end
end
