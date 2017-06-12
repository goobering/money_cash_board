require_relative '../db/sql_runner.rb'

class Transaction

  attr_reader :id
  attr_accessor :merchant_name, :value, :person_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i
    @merchant_name = options['merchant_name']
    @value = options['value'].to_i
    @person_id = options['person_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions (merchant_name, value, person_id, tag_id) VALUES ('#{@merchant_name}', #{@value}, #{@person_id}, #{@tag_id});"
    result = SqlRunner.run(sql)
  end

  def tag()
    return Tag.find(@tag_id)
  end

  def self.all()
    sql = "SELECT * FROM transactions;"
    result = SqlRunner.run(sql)
    return result.map { |transaction| Transaction.new(transaction)}
  end

  def self.all_by_person(person)
    sql = "SELECT * FROM transactions WHERE transactions.person_id = #{person.id};"
    result = SqlRunner.run(sql)
    return result.map {|transaction| Transaction.new(transaction)}
  end

  def self.all_by_tag(tag)
    sql = "SELECT * FROM transactions WHERE transactions.tag_id = #{tag.id};"
    result = SqlRunner.run(sql)
    return result.map {|transaction| Transaction.new(transaction)}
  end

  def self.all_for_person_by_tag(person, tag)
    sql = "SELECT * FROM transactions WHERE transactions.person_id = #{person.id} AND transactions.tag_id = #{tag.id};"
    result = SqlRunner.run(sql)
    return result.map {|transaction| Transaction.new(transaction)}
  end

  def self.sum_values(transactions)
    sum = 0
    for transaction in transactions
      sum += transaction.value
    end
    
    return sum
  end

end