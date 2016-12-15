module Fake

  class Generator

    def initialize(*columns)
      @columns = columns
    end

    def generate(count)
      Array.new(count) { Row.get(*@columns) }
    end

  end

end
