require 'sinatra/flash'
require 'byebug'
enable :sessions
register Sinatra::Flash

#UPDATE-EDIT
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :"static/edit"
end
# UPDATE -UPDATE
patch '/users/:id' do
  @user = User.find(params[:id])
  if @user.update(params[:user])
    erb :'static/profile'
  else
    erb :"static/edit"
  end
end

#READ-SHOW
get '/profile' do
  @user = User.find(session[:user_id])
  erb :"static/profile"
end

#CREATE-NEW
get '/gotosignup' do
  erb :"static/signup"
end
#CREATE-CREATE
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
