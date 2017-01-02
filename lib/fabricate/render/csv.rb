module Fabricate

  module Render

    class CSV

      def initialize(generator)
        @generator = generator
      end

      def render(count)
        rows = []
        @generator.generate(count) do |row|
          rows << row
        end
        rows
      end

    end

  end

end
