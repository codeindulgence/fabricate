require 'minitest/autorun'

require_relative '../lib/fake'

describe Fake do

  before do
    @fake = Fake.new
  end

  describe 'generating fake values' do

    it 'gives a name' do
      @fake.value('Name').must_be_instance_of String
    end

  end

end
