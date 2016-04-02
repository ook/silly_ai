class Living < Identifiable
  STATUSES = %i(idling falling suffocating)
  def initialize
    super
    @status = STATUSES.first
    @status_duration = 0
    @last_statuses = FifoMemory.new
    @cinetic_vector = Vector.new
  end

  def cinetic
    @cinetic_vector
  end

  def status=(status)
    raise "Illegal status #{status} for #{self.class.name}" unless STATUSES.include?(status)
    @status = status
  end

  def status
    @status
  end

  def status_duration
    @status_duration
  end

  def run_tick(env)
    puts env.inspect
    tick_story = Array("Damn, I\'m alive…")

    forced_status = env.delete(:forced_status)
    if forced_status
      log "fs:#{forced_status} s:#{status}"
      if forced_status != status
        @status_duration = 0
        self.status = forced_status
        tick_story << "I’m #{forced_status}!"
      end
    else
      if @last_statuses.see == :falling
        log("OUTCH! I was falling since #{@status_duration} ticks and now I touch the ground")
        self.status = :idling
        @status_duration = 0
      end
    end
    @last_statuses.push(status)
    @status_duration += 1

    tick_story << "I\'m #{status} for #{status_duration} tick."
    pos = env.delete(:pos)
    if pos
      tick_story << "I'm at #{pos}"
    end

    log tick_story.join(' ')
    raise "Haven't consume all my env: #{env.inspect}" unless env.keys.length == 0

  end

end
