require 'yaml'

module Fake

  class Proxy

    attr_reader :class, :method

    ALIASES = YAML.load_file './lib/fake/aliases.yaml'

    def initialize(type)
      klass, method = (ALIASES[type] || type).split '.'
      @method = method.nil? ? klass.downcase : method

      @class = Faker.const_get klass
    end

    def get
      @class.send @method
    end
  end
end
