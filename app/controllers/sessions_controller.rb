class SessionsController < ApplicationController
	before_action :block_access, except: [:destroy]

  def new
 
  	@user = User.find_by(email: params[:session][:email].downcase)
  
    if @user && user.authenticate(params[:session][:password])
    	sign_in(@user)
   	end
  end

  def create  
  
	@user = User.find_by(email: params[:session][:email].downcase)
    
    if @user && @user.authenticate(params[:session][:password])
    	sign_in(@user)
    	redirect_to home_path
    else
        render 'new'
    end
  end

  def destroy
  	
	sign_out
	redirect_to root_path
  end
end
