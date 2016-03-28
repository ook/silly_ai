require_relative 'lib/identifiable'
require_relative 'lib/world'
require_relative 'lib/living'

def log(message, output: $stdout, lf: true)
  time = Time.new.strftime("%Y%m%d %H:%M:%S")
  output << "[#{time}] #{message}" 
  output << "\n" if lf
  nil
end

def time_ms
  (Time.new.to_f * 1000).to_i
end

must_quit = false
log "Lux fiat"

world = World.new
living = Living.new

log world.identify
log living.identify

tick = 0

trap('INT') do
  must_quit = true
  log('INT trapped')
end

log('Trap set')

log('Entering the loop')

TICK_DURATION = 1_000 # millisecond

loop do
  tick_start = time_ms
  tick_stop = tick_start + TICK_DURATION
  log "tick #{tick} - #{time_ms}"

  end_of_tick = time_ms
  if end_of_tick < tick_stop
    sleep((tick_stop - end_of_tick) / 1_000)
  end
  log "Tick real duration: #{time_ms - tick_start}"
  tick += 1
  if must_quit
    log "Quitting the loop"
    break
  end
end

log('loop exited')
exit 0
