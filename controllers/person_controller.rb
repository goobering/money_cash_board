require 'sinatra'
require 'sinatra/contrib/all'
require_relative '../models/person.rb'
require_relative './transaction_controller.rb'

require 'pry-byebug'

post '/person' do
  redirect to("/person/#{params[:id]}/transactions")
end