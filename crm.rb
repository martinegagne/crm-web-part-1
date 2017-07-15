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

get '/contacts/new' do
  erb :new
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

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:         params[:email],
    note:          params[:note]
  )
  redirect to('/contacts')
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:         params[:email],
    note:          params[:note]
  )
  redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

after do
  ActiveRecord::Base.connection.close
end
