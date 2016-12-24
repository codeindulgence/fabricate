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

  describe Fabricate::CLI do

    subject { Fabricate::CLI }
    let(:args) { %w(10 Name,Email,Country) }

    it 'parses command line arguments' do
      options = subject.parse args
      options.count.must_equal 10
      options.columns.must_equal %w[Name Email Country]
    end

    # $ fabricate 10 Name,Email,Country
    it 'prints the data' do
      out, _ = capture_io do
        subject.execute! args
      end

      out.lines.length.must_equal 10
    end

    # $ fabricate 10 Name.name_with_quote,Name.name_with_newline
    it 'prints properly formatted CSV' do
      out, _ = capture_io do
        subject.execute! %w(1 Name.name_with_quote,Name.name_with_newline)
      end

      out.must_equal "\"First\"\"Last\",\"First\nLast\"\n"
    end

    describe 'column separator' do

      # $ fabricate 10 Name,Email,Country --col-sep="|"
      it 'can parse the column separator option' do
        subject.parse(%w(--col-sep |)).col_sep.must_equal '|'
      end

      it 'can specify CSV separators' do
        out, _ = capture_io do
          subject.execute! args + ['--col-sep="|"']
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
