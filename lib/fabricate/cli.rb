require 'csv'

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
          puts row.to_csv
        end
      end

    end
  end

end
