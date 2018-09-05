require 'sinatra'
require 'pg'
enable :sessions

load 'local_ENV.rb' if File.exist?('local_ENV.rb')
# conn = PG::Connection.open(:user => ENV['dbuser'], :password => ENV['dbpass'], :dbname => ENV['dbname'], :host => ENV['hostid'], :port => ENV['portid'])

get '/' do
    erb :dashboard
end

post '/account' do

	redirect '/profile'
end

post '/newuser' do
	username = params[:user]
	# conn.prepare("newuser1", "insert into info_table (uuid, usernames, pass) values($1, $2, $3)")
	# conn.exec_prepared('newuser1', ["abc", "jbrow43", "abc123"])
	redirect '/profile'
end

get '/profile' do

	erb :profile
end