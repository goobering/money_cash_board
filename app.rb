require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('models/person.rb')
require_relative('controllers/person_controller.rb')
require_relative('controllers/transaction_controller.rb')

get '/' do
  @people = Person.all()
  erb(:"people/index")
end