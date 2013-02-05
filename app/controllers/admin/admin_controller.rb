class Admin::AdminController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url
  end
end