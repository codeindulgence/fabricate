require 'optparse'

module Fabricate

  class CLI

    class << self

      def parse(args)
        args = args.clone
        {
          count: args.shift.to_i,
          columns: args.shift.split(',')
        }
      end

      def execute!(args)
        argh = parse args
        Generator.new(*argh[:columns]).generate argh[:count] do |row|
          puts row.join ','
        end
      end

    end
  end

end
