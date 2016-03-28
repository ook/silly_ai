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

  def log(message, output: $stdout, lf: true)
    time = Time.new.strftime("%Y%m%d %H:%M:%S")
    output << "[#{time}] #{@identifier} #{message}" 
    output << "\n" if lf
    nil
  end

end
