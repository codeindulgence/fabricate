require 'faker'

class Fake

  def value(type)
    Faker::Name.name
  end

end
