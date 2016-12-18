require 'minitest/autorun'

require_relative '../lib/fake'
require_relative 'spec_helper'

describe Fake do

  let(:columns) {%w(Name Email Country)}

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

    subject { Fake::Value }

    describe 'returning fake values' do

      it 'gives the right value type' do
        subject.get('Name').to_s.must_equal fake(:name)
        subject.get('Email').must_match fake(:email)
        subject.get('Address.country').must_equal fake(:country)
        subject.get('Country').must_equal fake(:country)
      end

    end

  end

  describe Fake::Row do

    subject { Fake::Row }

    describe 'returning a row' do

      it 'gives an array of Fake::Values' do
        is_fake_row? subject.get(*columns)
      end

    end

  end

  describe Fake::Generator do

    subject { Fake::Generator }

    describe 'generating rows' do

      it 'generates a bunch of rows' do
        count = 10
        rows = subject.new(*columns).generate(count)
        rows.length.must_equal count
        is_fake_row? rows.first
      end

      it 'yields to a block' do
        row = nil
        subject.new(*columns).generate(1) { |r| row = r }

        row.length.must_equal columns.length
        is_fake_row? row
      end

    end

  end

  describe Fake::CLI do

    subject { Fake::CLI }
    let(:args) { %w(10 Name,Email,Country) }

    it 'parses command line arguments' do
      subject.parse(args).must_equal \
        count: 10,
        columns: [
          'Name',
          'Email',
          'Country'
        ]
    end

    it 'prints the data' do
      out, _ = capture_io do
        subject.execute! args
      end

      out.lines.length.must_equal 10
    end

    describe 'bin/fake' do

      it 'prints the data' do
        out, _ = capture_subprocess_io do
          system "bin/fake #{args.join ' '}"
        end

        out.chomp.lines.length.must_equal 10
      end

    end

  end

end
