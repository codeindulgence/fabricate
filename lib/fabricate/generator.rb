module Fabricate

  class Generator

    def initialize(*columns)
      @columns = columns
    end

    def generate(count = nil)
      if block_given?
        block = proc { yield Row.get(*@columns) }
        if count.nil?
          loop(&block)
        else
          count.times(&block)
        end
        return
      else
        Array.new(count) { Row.get(*@columns) }
      end
    end

  end

end
