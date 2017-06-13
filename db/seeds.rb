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

person_1 = Person.new({'first_name' => 'Dave', 'last_name' => 'McDave', 'budget' => 1000})
person_1.save()
person_2 = Person.new({'first_name' => 'Bob', 'last_name' => 'McBob', 'budget' => 2000})
person_2.save()
person_3 = Person.new({'first_name' => 'Frieda', 'last_name' => 'McFrieda', 'budget' => 3000})
person_3.save()

tag_array = [
  {'name' => 'Arts'},
  {'name' => 'Music'},
  {'name' => 'Movies & DVDs'},
  {'name' => 'Newspaper'},
  {'name' => 'Tuition'},
  {'name' => 'Student Loan'},
  {'name' => 'Books & Supplies'},
  {'name' => 'Clothing'},
  {'name' => 'Books'},
  {'name' => 'Electronics & Software'},
  {'name' => 'Hobbies'},
  {'name' => 'Sporting Goods'},
  {'name' => 'Laundry'},
  {'name' => 'Hair'},
  {'name' => 'Spa & Massage'},
  {'name' => 'Dentist'},
  {'name' => 'Doctor'},
  {'name' => 'Eyecare'},
  {'name' => 'Pharmacy'},
  {'name' => 'Health Insurance'},
  {'name' => 'Gym'},
  {'name' => 'Sports'},
  {'name' => 'Kids Activites'},
  {'name' => 'Kids Allowance'},
  {'name' => 'Baby Supplies'},
  {'name' => 'Babysitter'},
  {'name' => 'Child Support'},
  {'name' => 'Toys'},
  {'name' => 'Groceries'},
  {'name' => 'Coffee shops'},
  {'name' => 'Fast Food'},
  {'name' => 'Restaurants'},
  {'name' => 'Alchohol & Bars'},
  {'name' => 'Gift'},
  {'name' => 'Charity'},
  {'name' => 'Television'},
  {'name' => 'Home Phone'},
  {'name' => 'Internet'},
  {'name' => 'Mobile Phone'},
  {'name' => 'Utilities'},
  {'name' => 'Gas & Fuel'},
  {'name' => 'Parking'},
  {'name' => 'Service & Auto Parts'},
  {'name' => 'Auto Payment'},
  {'name' => 'Auto Insurance'},
  {'name' => 'Air Travel'},
  {'name' => 'Rental Car & Taxi'},
  {'name' => 'Vacation'}
]

for tag in tag_array 
  new_tag = Tag.new(tag)
  new_tag.save()
end

transaction_1 = Transaction.new({'merchant_name' => 'Tesco', 'value' => 20, 'person_id' => person_1.id, 'tag_id' => Tag.all()[0].id, 'timestamp' => DateTime.now().to_s})
transaction_1.save()
transaction_2 = Transaction.new({'merchant_name' => 'B & Q', 'value' => 30, 'person_id' => person_2.id, 'tag_id' => Tag.all()[1].id, 'timestamp' => (DateTime.now() + 10).to_s})
transaction_2.save()
transaction_3 = Transaction.new({'merchant_name' => 'Netflix', 'value' => 40, 'person_id' => person_3.id, 'tag_id' => Tag.all()[2].id, 'timestamp' => (DateTime.now() + 20).to_s})
transaction_3.save()

binding.pry
nil