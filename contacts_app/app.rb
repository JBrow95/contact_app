require 'sinatra'
require 'pg'
require 'securerandom'
enable :sessions

load 'local_ENV.rb' if File.exist?('local_ENV.rb')
conn = PG::Connection.open(:user => ENV['dbuser'], :password => ENV['dbpass'], :dbname => ENV['dbname'], :host => ENV['hostid'], :port => ENV['portid'])

def prepare_statements(conn)
	conn.prepare("newuser4", "insert into user_info (uuid, user_id, user_pass) values($1, $2, $3)")
	conn.prepare("cons", "insert into contact_info (names, address, phone, owner) values($1, $2, $3, $4)")
end
prepare_statements(conn)

get '/' do

    erb :dashboard, locals:{msg: "", error: ""}
end

post '/account' do
	user = params[:user]
	pass = params[:pass]
	res = conn.exec("SELECT * FROM user_info WHERE user_id = '#{user}' AND user_pass = '#{pass}' ")
	res.each do |n|
		session[:id] = n['uuid']
		session[:user_name] = n['user_id']
		redirect '/profile'
	end
		erb :dashboard, locals:{error: "", msg: ""}
end

post '/newuser' do
	conn.exec_prepared('newuser4', [SecureRandom.uuid, params[:new_user] , params[:new_pass]])
	
	msg = "Account Created"
	erb :dashboard, locals:{msg: "Account Created"}
end

get '/profile' do
	res = conn.exec("SELECT * FROM contact_info WHERE owner = '#{session[:id]}'")
	res_arr = []
	res.each do |r|
		res_arr << r
	end


	username = session[:user_name]
	erb :profile, locals:{username: username, res_arr: res_arr}
end

post '/contacts' do
	person = params[:person]
	address = params[:address]
	phone = params[:phone]
	conn.exec_prepared('cons', [params[:person], params[:address], params[:phone], session[:id]])
	redirect '/profile'
end

