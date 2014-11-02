Bundler.require
require 'bundler'

require_relative "connection"
require_relative "models/user"
require_relative "models/page"

require_relative "helpers/form_helper"
helpers ActiveSupport::Inflector

enable :sessions

get '/' do
  @pages = Page.all
  erb :index
end

get '/pages' do
  @pages = Page.all(order: [created_at: desc])
  erb :'pages/index'
end

get '/pages/new' do
  erb :'pages/new'
end

post '/pages' do
  Page.create(params[:page])
  redirect '/'
end

get '/pages/:id' do
  @page = Page.find(params[:id])
  erb :"pages/show"
end

get '/pages/:id/edit' do
  @page = Page.find(params[:id])
  erb :"pages/edit"
end

patch 'pages/:id' do
  page = Page.find(params[:id])
  page.update(params[:page])
  redirect '/pages/params[:id]'
end

delete 'pages/:id' do
  Page.destroy(params[:id])
  redirect '/'
end

# USER SIGNUP/LOGIN
get '/users/signup' do
  erb :'users/signup'
end

post '/users' do
    user = User.new(params[:user])
    user.password = params[:password]
    user.save!
    redirect "/users/login"
end

get '/users/login' do
  erb :'users/login'
end

post '/sessions' do
  redirect '/' unless user = User.find_by({username: params[:username]})
  if user.password == params[:password]
    session[:current_user] = user.id
    redirect '/pages' # May redirect to... show
  else
    redirect '/' # May redirect to log-in
  end
end

