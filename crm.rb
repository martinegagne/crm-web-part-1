require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to '/contacts'
  erb :index
end

get '/contacts' do
  @landing_page = '/'
  @contacts = Contact.all

  erb :contacts
end

get '/about' do

  erb :about
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})

  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end

  erb :show_contact
end

after do
  ActiveRecord::Base.connection.close
end
