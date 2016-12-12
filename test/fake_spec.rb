require_relative 'spec_helper'

describe Fake::Proxy do

  it 'loads aliases from yaml' do
    Fake::Proxy::ALIASES.must_equal YAML.load_file('./lib/fake/aliases.yaml')
  end

  it 'resolves class aliases' do
    Fake::Proxy.new('Name').class.must_equal Faker::Name
    Fake::Proxy.new('Email').class.must_equal Faker::Internet
  end

  it 'resolves alias methods' do
    Fake::Proxy.new('Name').method.must_equal 'name'
    Fake::Proxy.new('Email').method.must_equal 'email'
  end

  it 'gets an aliased value' do
    reliably { Fake::Proxy.new('Name').get.must_equal 'Aric Smith' }
    reliably { Fake::Proxy.new('Email').get.must_equal 'aric.smith@keeblergoyette.co' }
  end

end

describe Fake::Value do

  describe 'generating fake values' do

    it 'gives the right value type' do
      reliably { Fake::Value.get('Name').to_s.must_equal 'Aric Smith' }
      reliably { Fake::Value.get('Email').must_equal 'aric.smith@keeblergoyette.co' }
      reliably { Fake::Value.get('Address.country').must_equal 'Canada' }
    end

  end

end
