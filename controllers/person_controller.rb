require 'sinatra'
require 'sinatra/contrib/all'
require_relative '../models/person.rb'
require_relative './transaction_controller.rb'

post '/person' do
  redirect to("/person/#{params[:id]}/transactions")
end

get '/person/:id/update' do
  @person = Person.find(params[:id].to_i)
  erb(:'people/update')
end

post '/person/:id/update' do
  @person = Person.find(params[:id].to_i)
  @person.update(params)
  redirect to "/"
end

get '/person/:id/delete' do
  @person = Person.find(params[:id].to_i)
  erb(:'people/delete')
end

post '/person/:id/delete' do
  person = Person.find(params[:id])
  person.delete()
  redirect to "/"
end