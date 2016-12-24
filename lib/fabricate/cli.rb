require 'optparse'
require 'ostruct'
require 'csv'

module Fabricate

  class CLI

    class << self

      def parse(args)
        options = OpenStruct.new \
          col_sep: ','

        OptionParser.new do |opts|
          opts.on("-c", "--col-sep STRING", "Specify the column separator (default ',').") do |v|
            options.col_sep = v
          end
        end.parse args

        options.count = args.shift.to_i
        options.columns = args.shift.split(',')

        options
      end

      def execute!(args)
        options = parse args
        Generator.new(*options.columns).generate options.count do |row|
          puts row.to_csv col_sep: options.col_sep
        end
      end

    end
  end

end
