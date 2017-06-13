require 'date'
require_relative '../db/sql_runner.rb'
require 'pry-byebug'
class Transaction

  attr_reader :id
  attr_accessor :merchant_name, :value, :person_id, :tag_id, :timestamp

  def initialize(options)
    @id = options['id'].to_i
    @merchant_name = options['merchant_name']
    @value = options['value'].to_f
    @person_id = options['person_id'].to_i
    @tag_id = options['tag_id'].to_i
    @timestamp = DateTime.parse(options['timestamp'])
  end

  def save()
    sql = "INSERT INTO transactions (merchant_name, value, person_id, tag_id, timestamp) VALUES ('#{@merchant_name}', #{@value}, #{@person_id}, #{@tag_id}, '#{@timestamp}');"
    result = SqlRunner.run(sql)
  end

  def tag()
    return Tag.find(@tag_id)
  end

  def update(options)
    sql = "UPDATE transactions SET (merchant_name, value, person_id, tag_id, timestamp) = ('#{options['merchant_name']}', #{options['value']}, #{options['person_id']}, #{options['tag_id']}, '#{options['timestamp']}') WHERE id = #{options['id']};"

    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id = #{@id};"
    SqlRunner.run(sql)
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

  def self.all_for_person_by_date_range(person, start_date, end_date)
    sql = "SELECT * FROM transactions WHERE transactions.person_id = #{person.id} AND transactions.timestamp > '#{start_date}' AND transactions.timestamp < '#{end_date}';"
    result = SqlRunner.run(sql)
    return result.map {|transaction| Transaction.new(transaction)}
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE transactions.id = #{id};"
    result = SqlRunner.run(sql)
    return Transaction.new(result[0])
  end

  def self.sum_values(transactions)
    sum = 0
    for transaction in transactions
      sum += transaction.value
    end
    
    return sum
  end

  def self.pretty_value(value)
    return '%.2f'% value
  end

  def self.pretty_timestamp(timestamp)
    return timestamp.strftime("%Y-%m-%dT%H:%M")
  end

end