require_relative '../db/sql_runner.rb'

class Person

attr_reader :id
attr_accessor :first_name, :last_name

def initialize(options)
  @id = options['id'].to_i
  @first_name = options['first_name']
  @last_name = options['last_name']
end

def save()
  sql = "INSERT INTO people (first_name, last_name) VALUES ('#{@first_name}', '#{last_name})' RETURNING *;"
  result = SqlRunner.run(sql)
  @id = result[0]['id'].to_i
end

end