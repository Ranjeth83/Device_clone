class AccountController < ApplicationController
  def signup
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.save
        UserNotifierMailer.signup_alert(@user).deliver
        flash[:notice] = "New account has been created"
        redirect_to :action=>"login"
      else 
        render :action=>"signup"
      end
    end
  end

  def login
    if request.post?
      @user = User.authenticate(params[:email],params[:password])
      if @user
        session[:user] = @user.id
        redirect_to :action=>:dashboard
      else  
        flash[:notice] = "Invalid email/password"
        render :action=>:login
      end
    end
  end

  def logout 
    session.delete(:user)
    flash[:notice] = "you logged out"
    redirect_to account_login_url
  end
  
  def dashboard
    if @user
      flash[:notice] = ""
    else
      redirect_to account_login_url
    end
  end

  def user_params
    params.permit(:first_name,:lastname,:email,:password,:password_confirmation,:encrypted_password,:mobile,:dob)
  end
end
