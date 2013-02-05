class ImagesController < ApplicationController
  load_and_authorize_resource

  DEFAULT_SIZE = '120x90'

  def index
    @imageable = find_imageable
    @images = @imageable.images
    size = params[:size] || DEFAULT_SIZE
    render :json => @images.collect { |p| p.to_jq_upload(size) }.to_json
  end

  def create
    @imageable = find_imageable
    authorize! :update, @imageable
    files = params[:files]
    size = params[:size] || DEFAULT_SIZE
    @images = []
    files.each do |file|
      @image = @imageable.images.new({:image => file})
      @image.user = current_user
      @image.save
      @images << @image.to_jq_upload(size)
    end
    render :json => @images.to_json
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render :json => {:success => true}
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    render :json => {:success => false, :message => 'Unauthorized'}
  end

  private

    def find_imageable
      params.each do |name, value|
        if name =~ /^(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

end