require 'optparse'
require 'ostruct'
require 'csv'

module Fabricate

  class CLI

    class << self

      def parse(args)
        options = OpenStruct.new \
          delimiter: ','

        OptionParser.new do |opts|
          opts.on '-d', '--delimiter STRING',
            %(Specify the column separator (default ',').) do |v|

            options.delimiter = v
          end

          opts.on '-c', '--columns Col1,Col2,Col3',
            Array,
            'Specify the desired column names',
            'Find class and method names at: https://github.com/stympy/faker/blob/master/README.md#usage' do |v|

            options.columns = v
          end

          opts.on '-n', '--count INTEGER',
            Integer,
            'Set the number of desired rows' do |v|

            options.count = v
          end
        end.parse args

        options
      end

      def execute!(args)
        options = parse args
        Generator.new(*options.columns).generate options.count do |row|
          puts row.to_csv col_sep: options.delimiter
        end
      end

    end
  end

end
