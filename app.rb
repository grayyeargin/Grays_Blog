Bundler.require
require 'bundler'

require_relative "connection"
require_relative "models/user"
require_relative "models/page"

require_relative "helpers/form_helper"
helpers ActiveSupport::Inflector

get '/' do
  erb :index
end

get '/pages' do
  @pages = Page.all
  erb :'pages/index'
end

get '/pages/new' do
  erb :'pages/new'
end

post '/pages' do
  Page.create(params[:page])
  redirect '/pages'
end

get '/pages/:id' do
  @page = Page.find(params[:id])
  erb :"page/show"
end

get '/pages/:id/edit' do
  @page = Page.find(params[:id])
  erb :"page/edit"
end

patch 'pages/:id' do
  page = Page.find(params[:id])
  page.update(params[:page])
  redirect '/pages/params[:id]'
end

delete 'pages/:id' do

end

# USER SIGNUP/LOGIN
get '/users/signup' do
  erb :'users/signup'
end

post '/users' do
  user = User.new(params[:user])
  user.password = params[:password]
  user.save!
  redirect "/login"
end

get '/login' do
  erb :'users/login'
end

post '/sessions' do
  redirect '/' unless user = User.find_by({username: params[:username]})
  if user.password == params[:password]
    session[:current_user] = user.id
    redirect
end

