require 'sinatra/flash'
require 'byebug'
enable :sessions
register Sinatra::Flash


post '/login' do
  @user = User.find_by(email: params[:user][:email])
  if @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    erb :"static/profile"
  else
    p "i am not logged in"
    erb :"static/index"
  end
end

post '/logout' do

  session.destroy
  redirect "/"
end
