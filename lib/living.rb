class Living < Identifiable
  def initialize
    super
  end

  def run_tick
    log('Damn, I\'m alive…')
  end
end
