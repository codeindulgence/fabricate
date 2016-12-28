require 'optparse'
require 'ostruct'
require 'csv'

module Fabricate

  class CLI

    class << self

      def parse(args)
        args << '--help' if args.empty?

        options = OpenStruct.new \
          delimiter: ','

        OptionParser.new do |opts|
          opts.banner = 'Fabricate: Generate random data'
          opts.separator "Version: #{Fabricate::VERSION}"
          opts.separator ''
          opts.separator 'Usage: fabricate [options]'

          opts.on '-d', '--delimiter STRING',
            %(Specify the column separator (default ',').) do |v|

            options.delimiter = v
          end

          opts.on '-c', '--columns TYPE1[,TYPE2[,...]]', Array,
            'Specify the desired column names',
            'Find type names at: https://github.com/stympy/faker/blob/master/README.md#usage' do |v|

            options.columns = v
          end

          opts.on '-n', '--count INTEGER', Integer,
            'Set the number of desired rows' do |v|

            options.count = v
          end

          opts.on("-h", "--help", "Prints this help") do
            options.help = opts
          end
        end.parse args

        options
      end

      def execute!(args)
        options = parse args
        if options.help
          puts options.help
        else
          Generator.new(*options.columns).generate options.count do |row|
            puts row.to_csv col_sep: options.delimiter
          end
        end
      end

    end
  end

end
