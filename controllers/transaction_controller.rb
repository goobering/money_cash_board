require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/transaction.rb'
require_relative '../models/person.rb'
require_relative '../models/tag.rb'

require 'pry-byebug'

get '/person/:id/transactions' do
  @person = Person.find(params[:id].to_i)
  @transaction_value = Transaction.sum_values(@person.transactions())
  @transactions = Transaction.all_by_person(@person)
  erb(:'transactions/index')
end

def get_tag_name(id)
  tag = Tag.find(id)
  return tag.name
end