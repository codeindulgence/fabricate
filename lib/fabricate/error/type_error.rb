module Fabricate

  class TypeError < FabricateError

    def initialize(type)
      super "Invalid type: #{type}"
    end

  end

end
