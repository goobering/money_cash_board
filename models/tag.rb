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

def self.all()
  sql = "SELECT * FROM tags;"
  result = SqlRunner.run(sql)
  return result.map { |tag| Tag.new(tag)}
end

def find()
  sql = "SELECT * FROM tags WHERE tags.id = #{@id};"
  result = SqlRunner.run(sql)
  return Tag.new(result[0])
end

def self.find(id)
  sql = "SELECT * FROM tags WHERE tags.id = #{id};"
  result = SqlRunner.run(sql)
  return Tag.new(result[0])
end

end