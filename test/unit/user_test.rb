require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name" do
    u = User.new
    u.name = '  Armin   Primadi  '
    self.assert_equal('Armin', u.first_name)
    self.assert_equal('Primadi', u.last_name)
    self.assert_equal('Armin Primadi', u.name)

    u.name = ' Armin   Primadi   Gunawan  '
    self.assert_equal('Armin', u.first_name)
    self.assert_equal('Primadi', u.last_name)
    self.assert_equal('Armin Primadi', u.name)

    u.name = ' armin primadi '
    self.assert_equal('Armin', u.first_name)
    self.assert_equal('Primadi', u.last_name)
    self.assert_equal('Armin Primadi', u.name)

    u.name = '    armin  '
    self.assert_equal('Armin', u.first_name)
    self.assert_equal(nil, u.last_name)
    self.assert_equal('Armin', u.name)

    u.name = '  123 456  '
    self.assert_equal(nil, u.first_name)
    self.assert_equal(nil, u.last_name)
  end
end
