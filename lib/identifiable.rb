class Identifiable
  def initialize
    @identifier = SecureRandom.hex(32)
    @identifier.freeze
  end
  
  def identify
    "#{self.class.name} uid=#{@identifier}"
  end

  def identifier
    @identifier
  end
end
