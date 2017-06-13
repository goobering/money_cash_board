require_relative '../db/sql_runner.rb'
require_relative './transaction.rb'

class Person

  attr_reader :id
  attr_accessor :first_name, :last_name, :budget

  def initialize(options)
    @id = options['id'].to_i
    @first_name = options['first_name']
    @last_name = options['last_name']
    @budget = options['budget'].to_f
  end

  def save()
    sql = "INSERT INTO people (first_name, last_name, budget) VALUES ('#{@first_name}', '#{last_name}', #{budget}) RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def find()
    sql = "SELECT * FROM people WHERE people.id = #{@id};"
    result = SqlRunner.run(sql)
    return Person.new(result[0])
  end

  def transactions()
    return Transaction.all_by_person(self)
  end

  def remaining_budget()
    return @budget - Transaction.sum_values(transactions())
  end

  def update(options)
      sql = "UPDATE people SET (first_name, last_name, budget) = ('#{options['first_name']}', '#{options['last_name']}', #{options['budget']}) WHERE id = #{options['id']};"
      SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM people WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def over_budget()
    return remaining_budget() < 0
  end

  def self.all()
    sql = "SELECT * FROM people;"
    result = SqlRunner.run(sql)
    return result.map { |person| Person.new(person) }
  end

  def self.find(id)
    sql = "SELECT * FROM people WHERE people.id = #{id};"
    result = SqlRunner.run(sql)
    return Person.new(result[0])
  end

  def self.pretty_value(value)
    return '%.2f'% value
  end

end