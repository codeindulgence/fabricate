require_relative 'spec_helper'

describe Fake::Proxy do

  subject { Fake::Proxy }

  it 'loads aliases from yaml' do
    subject::ALIASES.must_equal YAML.load_file('./lib/fake/aliases.yaml')
  end

  it 'resolves class aliases' do
    subject.new('Name').class.must_equal Faker::Name
    subject.new('Email').class.must_equal Faker::Internet
  end

  it 'resolves alias methods' do
    subject.new('Name').method.must_equal 'name'
    subject.new('Email').method.must_equal 'email'
  end

  it 'gets an aliased value' do
    subject.new('Name').get.must_equal 'John Doe'
    subject.new('Email').get.must_match fake(:email)
  end

end

describe Fake::Value do

  describe 'generating fake values' do

    it 'gives the right value type' do
      Fake::Value.get('Name').to_s.must_equal fake(:name)
      Fake::Value.get('Email').must_match fake(:email)
      Fake::Value.get('Address.country').must_equal fake(:country)
      Fake::Value.get('Country').must_equal fake(:country)
    end

  end

  describe 'generating a row' do

    it 'gives an array of Fake::Values' do
      columns = %w(Name Email Country)
      name, email, country = Fake::Row.get(*columns)
      name.must_equal fake(:name)
      email.must_match fake(:email)
      country.must_equal fake(:country)
    end

  end

end
