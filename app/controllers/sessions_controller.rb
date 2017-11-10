class SessionsController < ApplicationController
	before_action :block_access, except: [:destroy]
  skip_before_action :verify_authenticity_token

  def new
  	@user = User.find_by(email: params[:email].downcase)
  
    if @user && user.authenticate(params[:password])
    	sign_in(@user)
   	end

    respond_to do |format|
      format.json { render json: logged_in? }
    end

    return "success"
  end

  def create  
	  @user = User.find_by(email: params[:email].downcase)
    
    if @user && @user.authenticate(params[:password])
    	sign_in(@user)
    end

    respond_to do |format|
      format.json { render json: logged_in? }
    end
      
    return "success"

  end

  def destroy
  	
  	sign_out
  	redirect_to root_path
  end
end
