require 'Minitest/autorun'
require 'Minitest/rg'

require_relative '../models/tag.rb'

class TestTag < Minitest::Test

  def setup()
    @test_tag = Tag.new({'name' => 'Food'})
  end

  def test_create_tag()
    assert_equal(true, @test_tag.is_a?(Tag))
    assert_equal("Food", @test_tag.name)
  end

end