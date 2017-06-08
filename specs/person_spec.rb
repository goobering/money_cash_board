require 'Minitest/autorun'
require 'Minitest/rg'

require_relative '../models/person.rb'

class TestPerson < Minitest::Test

  def setup()
    @test_person = Person.new({'first_name' => 'Dave', 'last_name' => 'McDave'})
  end

  def test_create_person()
    assert_equal(true, @test_person.is_a?(Person))
    assert_equal("Dave", @test_person.first_name)
    assert_equal("McDave", @test_person.last_name)
  end

end