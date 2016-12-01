require 'faker'

module Fake

  class Value

    def initialize(type)
      @value = Faker::Name.name
    end

    def to_s
      @value.to_s
    end

    class << self

      def get(type)
        new type
      end

    end

  end

end
