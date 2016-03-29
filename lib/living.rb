class Living < Identifiable
  STATUSES = %i(idling falling)
  def initialize
    super
    @status = STATUSES.first
    @status_duration = 0
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
    tick_story = Array("Damn, I\'m alive…")

    env_status = env.delete(:forced_status)
    if env_status
      forced_status = forced_status[:status]
      log "fs:#{forced_status} s:#{status}"
      if forced_status != status
        @status_duration = 0
        self.status = forced_status
        tick_story << "I’m #{forced_status}!"
      end
      duration = forced_status[:since]
    end
    @status_duration += 1

    tick_story << "I\'m #{status} for #{status_duration}"
    pos = env.delete(:pos)
    if pos
      tick_story << "I'm at #{pos}"
    end

    log tick_story.join(' ')
    raise "Haven't consume all my env: #{env.inspect}" unless env.keys.length == 0
  end

end
