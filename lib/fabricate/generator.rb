module Fabricate

  class Generator

    attr_reader :columns

    def initialize(*columns)
      @columns = columns
    end

    def generate(count = nil)
      enumerator = count.nil? ? loop : count.times
      enumerator.each { yield Row.get(*@columns) }
    end

  end

end
