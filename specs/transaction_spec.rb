require 'Minitest/autorun'
require 'Minitest/rg'

require_relative '../models/transaction.rb'
require_relative '../models/person.rb'
require_relative '../models/tag.rb'
require_relative '../db/sql_runner.rb'

class TestTransaction < Minitest::Test

  def setup()
    @person_1 = Person.new('first_name' => 'Dave', 'last_name' => 'McDave')
    @person_1.save()
    @tag_1 = Tag.new('name' => 'Food')
    @tag_1.save()
    @test_transaction = Transaction.new({'merchant_name' => 'Tesco', 'value' => 20, 'person_id' => "#{@person_1.id}".to_i, 'tag_id' => "#{@tag_1.id}".to_i, })
  end

  def test_create_transaction()
    assert_equal(true, @test_transaction.is_a?(Transaction))
    assert_equal("Tesco", @test_transaction.merchant_name)
    assert_equal(20, @test_transaction.value)
    assert_equal(@person_1.id, @test_transaction.person_id)
    assert_equal(@tag_1.id, @test_transaction.tag_id)
  end

end