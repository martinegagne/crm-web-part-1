require_relative 'contact'
require 'sinatra'

get '/' do
  @contact_link = "localhost:4567/contacts"
  erb :index
end

get '/contacts' do
  @contacts = Contact.all
  erb :contacts
end

after do
  ActiveRecord::Base.connection.close
end
