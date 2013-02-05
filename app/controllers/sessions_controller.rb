class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    #respond_with resource, :location => after_sign_in_path_for(resource)
    redirect_to after_sign_in_path_for(resource)
  end

  def destroy
    super
  end
end