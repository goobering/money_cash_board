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
post '/person/:id/searchbytag' do
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

# Display form for creating a new transaction
get '/person/:id/transactions/new' do
  @person = Person.find(params[:id].to_i)
  @tags = Tag.all()
  erb(:'transactions/new_transaction')
end

# Process response from create new transaction, display confirmation
post '/person/:person_id/transactions' do
  @person = Person.find(params[:person_id].to_i)
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:'transactions/create_transaction')
end

# Display form for updating a transaction
get '/person/:id/transactions/:transaction_id/update' do
  @person = Person.find(params[:id].to_i)
  @transaction = Transaction.find(params[:transaction_id].to_i)
  @tags = Tag.all()
  erb(:'transactions/update')
end

# Process response from update transaction
post '/person/:person_id/transactions/:id/update' do
  @person = Person.find(params[:person_id].to_i)
  @transaction = Transaction.find(params[:id].to_i)
  @transaction.update(params)
  redirect to "/person/#{params[:person_id]}/transactions"
end

# /person/<%= @person.id %>/transactions/<%= transaction.id %>/delete