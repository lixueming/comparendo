class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:check_email]

  def check_email
    @user = User.find_by_email(params[:user][:email])
    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  def profil
    @user = current_user
    if request.put?
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Profile was successfully updated.'
      else
        flash[:error] = @user.errors.values[0][0]
      end
    end
  end

end
