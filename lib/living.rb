class Living < Identifiable
  def initialize
    super
  end

  def run_tick(env)
    log("Damn, I\'m alive… At #{env[:pos]}")
  end

end
