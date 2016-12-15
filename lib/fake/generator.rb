module Fake

  class Generator

    def initialize(*columns)
      @columns = columns
    end

    def generate(count)
      if block_given?
        count.times { yield Row.get(*@columns) }
        return
      else
        Array.new(count) { Row.get(*@columns) }
      end
    end

  end

end
