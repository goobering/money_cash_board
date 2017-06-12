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
  @tags = Tag.all()
  erb(:'transactions/index')
end

post '/person/:id/searchbytag/' do
  redirect to("/person/#{params[:id]}/transactions/searchbytag/#{params[:tag_id]}")
end

get '/person/:id/transactions/searchbytag/:tag_id' do
  @person = Person.find(params[:id].to_i)
  @tag = Tag.find(params[:tag_id].to_i)
  @transactions = Transaction.all_for_person_by_tag(@person, @tag)
  @transaction_value = Transaction.sum_values(@transactions)
  erb(:'transactions/search_by_tag')
end