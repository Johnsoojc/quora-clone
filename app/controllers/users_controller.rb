require 'sinatra/flash'
require 'byebug'
enable :sessions
register Sinatra::Flash


get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :"static/update"
end

patch '/users/:id' do
  @user = User.find(params[:id])
  if @user.update(params[:user])
# if user[:name] = user[:name]
#   @user.save
    erb :'static/profile'
  else
    erb :"static/update"
  end
end

get '/profile' do
  @user = User.find(session[:user_id])
  erb :"static/profile"
end


get '/gotosignup' do
  erb :"static/signup"
end

post '/signup' do
user = User.new(params[:user])
  if user.save
    flash[:alert]="YOU HAVE SUCCESFULLY SIGNED UP! LOG IN NOW"
    erb :'static/index'
  else
    #flash[:notice] = "You are not sucesfully signing up"
    p "user not saved"
    erb :'static/signup'
  end

end

get 'backtoprofile' do
  erb :"static/profile"
end
