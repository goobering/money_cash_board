require 'pry-byebug'

require_relative '../models/person.rb'
require_relative '../models/tag.rb'

person_1 = Person.new('first_name' => 'Dave', 'last_name' => 'McDave')
person_1.save()
person_2 = Person.new('first_name' => 'Bob', 'last_name' => 'McBob')
person_2.save()
person_3 = Person.new('first_name' => 'Frieda', 'last_name' => 'McFrieda')
person_3.save()


tag_1 = Tag.new('name' => 'Food')
tag_1.save()
tag_2 = Tag.new('name' => 'Travel')
tag_2.save()
tag_3 = Tag.new('name' => 'Pets')
tag_3.save()

binding.pry
nil