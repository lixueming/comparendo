class ReviewsController < ApplicationController

  before_filter :authenticate_user!

  # TODO: protect access
  def create
    @reviewable = find_reviewable
    @review = @reviewable.reviews.new(params[:review])
    @review.user = current_user
    if @review.save
      render :json => {:success => true}
    else
      render :json => {:success => false, :message => @review.errors.values[0][0] }
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    render :json => {:success => true}
  end

  private

    def find_reviewable
      params.each do |name, value|
        if name =~ /^(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

end