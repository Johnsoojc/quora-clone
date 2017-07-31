require 'sinatra/flash'
require 'byebug'
enable :sessions
register Sinatra::Flash


get "/" do
  erb :"static/index"
end
