require 'minitest/autorun'

require_relative '../lib/fake/value'

# Since we're testing stuff that's normally random, let's ensure the same seed
# each time
def reliably(&block)
  srand 1
  block.call
end
