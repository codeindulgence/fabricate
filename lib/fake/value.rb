module Fake

  class Value

    def initialize(type)
      proxy = Proxy.new type
      @value = proxy.get
    end

    def to_s
      @value.to_s
    end

    class << self

      def get(type)
        %(#{new type})
      end

    end

  end

end
