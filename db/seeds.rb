require 'pry-byebug'

require_relative '../models/person.rb'
require_relative '../models/tag.rb'
require_relative '../models/transaction.rb'

sql = "DELETE FROM transactions;"
SqlRunner.run(sql)
sql = "DELETE FROM tags;"
SqlRunner.run(sql)
sql = "DELETE FROM people;"
SqlRunner.run(sql)

person_1 = Person.new({'first_name' => 'Dave', 'last_name' => 'McDave'})
person_1.save()
person_2 = Person.new({'first_name' => 'Bob', 'last_name' => 'McBob'})
person_2.save()
person_3 = Person.new({'first_name' => 'Frieda', 'last_name' => 'McFrieda'})
person_3.save()

tag_1 = Tag.new({'name' => 'Food'})
tag_1.save()
tag_2 = Tag.new({'name' => 'Travel'})
tag_2.save()
tag_3 = Tag.new({'name' => 'Pets'})
tag_3.save()

transaction_1 = Transaction.new({'merchant_name' => 'Tesco', 'value' => 20, 'person_id' => person_1.id, 'tag_id' => tag_1.id})
transaction_1.save()
transaction_2 = Transaction.new({'merchant_name' => 'B & Q', 'value' => 30, 'person_id' => person_2.id, 'tag_id' => tag_2.id})
transaction_2.save()
transaction_3 = Transaction.new({'merchant_name' => 'Netflix', 'value' => 40, 'person_id' => person_3.id, 'tag_id' => tag_3.id})
transaction_3.save()

binding.pry
nil