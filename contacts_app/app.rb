require 'sinatra'
# require_relative 'calc.rb'
# load './local_env.rb' if File.exist?('./local_env.rb')

enable :sessions

get '/' do
    erb :dashboard
end

post '/account' do

	redirect '/profile'
end

get '/profile' do

	erb :profile
end