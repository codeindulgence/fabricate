module Fake

  class Row

    class << self

      def get(*columns)
        columns.map do |column|
          Value.get column
        end
      end

    end

  end

end
