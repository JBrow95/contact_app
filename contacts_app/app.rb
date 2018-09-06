require 'sinatra'
require 'pg'
require 'securerandom'
enable :sessions

load 'local_ENV.rb' if File.exist?('local_ENV.rb')
# conn = PG::Connection.open(:user => ENV['dbuser'], :password => ENV['dbpass'], :dbname => ENV['dbname'], :host => ENV['hostid'], :port => ENV['portid'])

def prepare_statements(conn)
	conn.prepare("newuser4", "insert into user_info (uuid, user_id, user_pass) values($1, $2, $3)")
end
prepare_statements(conn)
get '/' do
	
    erb :dashboard, locals:{msg: "", error: ""}
end

post '/account' do

	redirect '/profile'
end

post '/newuser' do
	conn.exec_prepared('newuser4', [SecureRandom.uuid, params[:new_user] , params[:new_pass]])
	if params[:new_user] == 
		error = "Username Taken"
		erb :dashboard, locals:{error: "Username Taken"}
	else
	msg = "Account Created"
	erb :dashboard, locals:{msg: "Account Created"}
	end
end

get '/profile' do

	erb :profile
end