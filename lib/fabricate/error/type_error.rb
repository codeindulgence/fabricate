module Fabricate

  class TypeError < StandardError

    def initialize(type)
      super "Invalid type: #{type}"
    end

  end

end
