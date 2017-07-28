class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  has_secure_password
  #this is a method inside gem bcrpyt that allows Userto encrypt the password given ,
  # and able to autheticate it automatically
end
