require 'yaml'

module Fabricate

  class Proxy

    attr_reader :class, :method

    ALIASES = YAML.load_file './lib/fabricate/aliases.yaml'

    def initialize(type)
      @type = type
      klass, method = (ALIASES[type] || type).split '.'
      @method = method.nil? ? klass.downcase : method

      @class = Faker.const_get klass rescue raise TypeError, "Invalid type: #{type}"
    end

    def get
      @class.send @method rescue raise TypeError, "Invalid type: #{@type}"
    end
  end
end
