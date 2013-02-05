class Admin::ArticlesController < Admin::AdminController
  set_tab :article
	before_filter :init_article, :only => [:edit, :update, :show, :destroy]
  add_breadcrumb "Informationen", "/infos"

  def index
		@articles = Article.order("id").page(params[:page])
	end

	def new
		@article = current_user.articles.new
		@article.images.build
    add_breadcrumb "#{t('article.create')}", ""
	end

	def create
		@article = current_user.articles.new params[:article]
		respond_to do |format|
			if @article.save
				format.html { redirect_to admin_article_path(@article)}
			else
				flash[:error] = @article.errors.full_messages.join(", ")
				format.html { render :new }
			end
		end
	end

	def show
	end

	def edit
		@article.images.build unless @article.has_cover_image?
    add_breadcrumb "#{@article.title}", "/infos/#{@article.path}"
    add_breadcrumb "#{t('article.edit')}", ""
	end

	def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
      		format.html {redirect_to admin_article_path(@article)}
         format.json  { render :json => @article }
      else
        format.json  { render :json => @article.errors }
      end
    end
	end

	def destroy
		@article.destroy
		respond_to do |format|
			format.html { redirect_to admin_articles_path }
		end
	end

	def tags
		@articles = Article.order("id")
		@tags = @articles.map(&:tags).join(",").split(",").uniq
		@tags.map!{|t| t if t.include?(params[:term])}.compact! unless params[:term].blank?
		respond_to do |format|
      format.json { render :json => @tags.map{|t| {:id => t, :label => t, :value => t }} }
    end
	end

	private
		def init_article
			@article = Article.find_by_id params[:id]
			redirect_to admin_articles_path if @article.nil?
		end
end
