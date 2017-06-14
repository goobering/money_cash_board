require 'sinatra'
require 'sinatra/contrib/all'
require 'date'

require_relative '../models/transaction.rb'
require_relative '../models/person.rb'
require_relative '../models/tag.rb'

require 'pry-byebug'

# Show list of transactions belonging to given user
get '/person/:id/transactions' do
  @person = Person.find(params[:id].to_i)
  @budget_value = Person.pretty_value(@person.budget)
  @transactions = Transaction.all_by_person(@person)
  @transaction_value = Transaction.pretty_value(Transaction.sum_values(@person.transactions()))
  @remaining_value = Person.pretty_value(@person.remaining_budget())
  @tags = Tag.all()

  erb(:'transactions/index')
end

# Accept tag name selected by user, redirect to appropriate page of transactions
post '/person/:id/transactions/searchbytag' do
  redirect to("/person/#{params[:id]}/transactions/searchbytag/#{params[:tag_id]}")
end

# Display transactions belonging to a given user, with a given tag
get '/person/:id/transactions/searchbytag/:tag_id' do
  @person = Person.find(params[:id].to_i)
  @budget_value = Person.pretty_value(@person.budget)
  @transactions = Transaction.all_for_person_by_tag(@person, @tag)
  @transaction_value = Transaction.pretty_value(Transaction.sum_values(@transactions))
  @remaining_value = Person.pretty_value(@person.remaining_budget())
  @tag = Tag.find(params[:tag_id].to_i)
  @tags = Tag.all()

  erb(:'transactions/search_by_tag')
end

# Accept tag name selected by user, redirect to appropriate page of transactions
post '/person/:id/transactions/searchbydate' do
  # Forward the params from the POSTed form to the searchbydate page
  query = params.map{|key, value| "#{key}=#{value}"}.join("&")
  redirect to("/person/#{params[:id]}/transactions/searchbydate?#{query}")
end

# Display transactions belonging to a given user, with a given date range
get '/person/:id/transactions/searchbydate' do
  @person = Person.find(params[:id].to_i)
  @budget_value = Person.pretty_value(@person.budget)
  @transactions = Transaction.all_for_person_by_date_range(@person, params[:start_date], params[:end_date])
  @transaction_value = Transaction.pretty_value(Transaction.sum_values(@transactions))
  @remaining_value = Person.pretty_value(@person.remaining_budget())
  @tags = Tag.all()

  erb(:'transactions/search_by_date')
end

# Display form for creating a new transaction
get '/person/:id/transactions/new' do
  @person = Person.find(params[:id].to_i)
  @default_time = DateTime.now().strftime("%Y-%m-%dT%H:%M")
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

# Delete a transaction, redirect to main transaction list
post '/person/:person_id/transactions/:id/delete' do
  transaction = Transaction.find(params[:id])
  transaction.delete()
  redirect to "/person/#{params[:person_id]}/transactions"
end
