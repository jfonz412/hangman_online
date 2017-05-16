require 'sinatra'
require 'sinatra/reloader'

# enable session features
configure do
	enable :sessions 
end

get '/' do
	name = params['name']
	erb :index, :locals => {:name => name}
end
