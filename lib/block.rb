# Block can't be instanciated
class Block
  BLOCKS = [
    { name: 'bedrock' }.freeze
  ].freeze

  def self.find(index)
    BLOCKS[index]
  end

  private

  def initialize
    raise 'No instance needed'
  end
end
