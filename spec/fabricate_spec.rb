require 'minitest/autorun'

require_relative '../lib/fabricate'
require_relative 'spec_helper'

describe Fabricate do

  let(:columns) {%w(Name Email Country)}

  describe Fabricate::Proxy do

    subject { Fabricate::Proxy }

    it 'loads aliases from yaml' do
      subject::ALIASES.must_equal YAML.load_file('./lib/fabricate/aliases.yaml')
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

    describe 'invalid types' do

      it 'raises a TypeError' do
        proc {
          subject.new('Kountry')
        }.must_raise Fabricate::TypeError

        proc {
          subject.new('Name.failure').get
        }.must_raise Fabricate::TypeError
      end

    end

  end

  describe Fabricate::Value do

    subject { Fabricate::Value }

    describe 'returning fake values' do

      it 'gives the right value type' do
        subject.get('Name').to_s.must_equal fake(:name)
        subject.get('Email').must_match fake(:email)
        subject.get('Address.country').must_equal fake(:country)
        subject.get('Country').must_equal fake(:country)
      end

    end

  end

  describe Fabricate::Row do

    subject { Fabricate::Row }

    describe 'returning a row' do

      it 'gives an array of Fabricate::Values' do
        is_fake_row? subject.get(*columns)
      end

    end

  end

  describe Fabricate::Generator do

    subject { Fabricate::Generator }

    describe 'generating rows' do

      it 'yields to a block' do
        row = nil
        subject.new(*columns).generate(1) { |r| row = r }

        row.length.must_equal columns.length
        is_fake_row? row
      end

    end

  end

  describe Fabricate::CLI do

    subject { Fabricate::CLI }
    let(:args) { %w(--count 10 --columns Name,Email,Country) }

    describe 'help and usage' do
      it 'responds to --help' do
        out, _ = capture_io do
          subject.new(%w(--help)).execute!
        end

        out.must_match(/Usage/)
      end

      it 'responds to no args being passed' do
        out, _ = capture_io do
          subject.new([]).execute!
        end

        out.must_match(/Usage/)
      end
    end

    it 'parses command line arguments' do
      options = subject.new(args).options
      options.count.must_equal 10
      options.columns.must_equal %w[Name Email Country]
    end

    # $ fabricate 10 Name,Email,Country
    it 'prints the data' do
      out, _ = capture_io do
        subject.new(args).execute!
      end

      out.lines.length.must_equal 10
    end

    # $ fabricate 10 Name.name_with_quote,Name.name_with_newline
    it 'prints properly formatted CSV' do
      out, _ = capture_io do
        subject.new(%w(-n 1 -c Name.name_with_quote,Name.name_with_newline)).execute!
      end

      out.must_equal "\"First\"\"Last\",\"First\nLast\"\n"
    end

    describe 'column separator' do

      # $ fabricate 10 Name,Email,Country --delimiter="|"
      it 'can parse the delimiter option' do
        subject.new(%w(--delimiter |)).options.delimiter.must_equal '|'
      end

      it 'can specify CSV separators' do
        out, _ = capture_io do
          subject.new(args + ['--delimiter="|"']).execute!
        end

        out.lines.first.split('|').length.must_equal 3, out.lines.first
      end

    end

    describe 'bin/fabricate' do

      it 'prints the data' do
        out, _ = capture_subprocess_io do
          system "bin/fabricate #{args.join ' '}"
        end

        out.lines.length.must_equal 10
      end

    end

  end

end
