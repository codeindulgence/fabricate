require 'minitest/autorun'

require_relative '../lib/fake'

I18n.load_path = [File.expand_path('test/lib/locales/en.yml')]

def fake(id)
  fakes = {
    name: Faker::Name.name,
    country: Faker::Address.country
  }

  fakes[:email] = Regexp.new sprintf('%s.*@.*%s\.com', *fakes[:name].downcase.split)

  fakes[id]
end
