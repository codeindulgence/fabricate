require_relative 'spec_helper'

describe Fake::Value do

  describe 'generating fake values' do

    it 'gives a name' do
      reliably do
        Fake::Value.get('Name').to_s.must_equal 'Mina Abbott'
      end
    end

  end

end
