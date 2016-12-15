module Fake

  class Row

    class << self

      def get(*types)
        types.map do |type|
          Value.get type
        end
      end

    end

  end

end
