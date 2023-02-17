class PasswordController < ApplicationController
  def forgot_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_password = create_random_password
        @user.update(:password=>new_password)
        UserNotifierMailer.forgot_alert(@user,new_password).deliver
        #action mailer
        puts "=========="
        puts new_password
        redirect_to account_login_url
      else
        flash[:notice] = "Invalid email id, please enter valid email"
        render :action=>forgot_password
      end 
    end
  end

  def create_random_password
    (0...8).map {(65+rand(26)).chr}.join
  end

  def reset_password
    @user = User.find(session[:user])
    if request.post?
        if @user
          if @user.update(user_params)
            UserNotifierMailer.reset_alert(@user).deliver
            #action mailer
            flash[:notice] = "Your password has been changed."
            redirect_to account_dashboard_url
            else  
            render :action=>:reset_password
          end
        end
    end
  end

  def user_params
    params.permit(:password,:password_confirmation)
  end
end
