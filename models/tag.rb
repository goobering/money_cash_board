require_relative '../db/sql_runner.rb'

class Tag

attr_reader :id
attr_accessor :name

def initialize(options)
  @id = options['id'].to_i
  @name = options['name']
end

def save()
  sql = "INSERT INTO tags (name) VALUES ('#{@name}') RETURNING *;"
  result = SqlRunner.run(sql)
  @id = result[0]['id'].to_i
end

end