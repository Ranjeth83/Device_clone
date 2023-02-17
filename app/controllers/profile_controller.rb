class ProfileController < ApplicationController
  def edit_profile
    @user = User.find(session[:user])
    if request.post?
      if @user
        if @user.update(user_params)
          flash[:notice] = "you profile is updated"
          redirect_to account_dashboard_url
        else
          render :action=>:edit_profile
        end
      end
    end
  end

  def user_params
    params.permit(:first_name,:lastname,:mobile,:dob,:header_image)
  end
end
