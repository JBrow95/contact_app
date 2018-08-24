require 'sinatra'
# require_relative 'calc.rb'
load './local_env.rb' if File.exist?('./local_env.rb')

enable :sessions

get '/' do

end
