Bundler.require
require 'bundler'

require_relative "connection"
require_relative "models/user"
require_relative "models/page"

get '/' do
  erb :index
end

get '/pages' do

end

get '/pages/new' do

end

post '/pages' do

end

get '/pages/:id' do

end

get '/pages/:id/edit' do

end

patch 'pages/:id' do

end

delete 'pages/:id' do

end