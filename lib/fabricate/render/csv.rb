require 'csv'

module Fabricate

  module Render

    class CSV

      def initialize(generator)
        @generator = generator
      end

      def render(options)
        puts @generator.columns.to_csv if options[:header]
        @generator.generate(options[:count]) do |row|
          puts row.to_csv(csv_options_from options)
        end
      end

      private

      def csv_options_from(options)
        {
          col_sep: (options[:delimiter] or ',')
        }
      end

    end

  end

end
