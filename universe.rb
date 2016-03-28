require 'securerandom'

require_relative 'lib/identifiable'
require_relative 'lib/position'
require_relative 'lib/world'
require_relative 'lib/living'

def time_ms
  (Time.new.to_f * 1000).to_i
end

must_quit = false

world = World.new
world.log "Lux fiat"

world.size = 16
world.setup

tick = 0

trap('INT') do
  must_quit = true
  world.log('INT trapped')
end

world.log('Trap set')

world.log('Entering the loop')

TICK_DURATION = 1_000 # millisecond

loop do
  tick_start = time_ms
  tick_stop = tick_start + TICK_DURATION
  world.log "tick #{tick} - #{time_ms}"

  world.run_tick

  end_of_tick = time_ms
  world.log "Used tick time: #{end_of_tick - tick_start}"
  if end_of_tick < tick_stop
    sleep((tick_stop - end_of_tick) / 1_000)
  end
  world.log "Tick real duration: #{time_ms - tick_start}"
  tick += 1
  if must_quit
    world.log "Quitting the loop"
    break
  end
end

world.log('loop exited')
world.log('Armaggedon')
exit 0
