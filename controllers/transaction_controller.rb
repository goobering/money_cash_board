require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/transaction.rb'
require_relative '../models/person.rb'
require_relative '../models/tag.rb'

require 'pry-byebug'

# Show list of transactions belonging to given user
get '/person/:id/transactions' do
  @person = Person.find(params[:id].to_i)
  @transaction_value = Transaction.sum_values(@person.transactions())
  @transactions = Transaction.all_by_person(@person)
  @tags = Tag.all()
  erb(:'transactions/index')
end

# Accept tag name selected by user, redirect to appropriate page of transactions
post '/person/:id/searchbytag/' do
  redirect to("/person/#{params[:id]}/transactions/searchbytag/#{params[:tag_id]}")
end

# Display transactions belonging to a given user, with a given tag
get '/person/:id/transactions/searchbytag/:tag_id' do
  @person = Person.find(params[:id].to_i)
  @tag = Tag.find(params[:tag_id].to_i)
  @transactions = Transaction.all_for_person_by_tag(@person, @tag)
  @transaction_value = Transaction.sum_values(@transactions)
  @tags = Tag.all()
  erb(:'transactions/search_by_tag')
end

get '/person/:id/transactions/new' do
  @person = Person.find(params[:id].to_i)
  @tags = Tag.all()
  erb(:'transactions/new_transaction')
end

post '/person/:id/transactions' do
  @person = Person.find(params[:id].to_i)
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:'transactions/create_transaction')
end

get '/person/:id/transactions/:transaction_id/update' do
  @person = Person.find(params[:id].to_i)
  @transaction = Transaction.find(params[:transaction_id].to_i)
  @tags = Tag.all()
  erb(:'transactions/update')
end

post '/person/:id/transactions/:transaction_id/update' do

end