class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale, :export_i18n_messages
 
  def set_locale
    I18n.locale = "en"#extract_locale_from_subdomain
  end
  
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    if !parsed_locale
      parsed_locale = "de"
    end
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : "de"
  end

  # re-export translations in js file every request in dev. env.
  def export_i18n_messages
    SimplesIdeias::I18n.export! if Rails.env.development?
  end

  #check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def newest_infos
    @newest_infos = Article.last_five
  end

  protected

  def render_404
    redirect_to '/404.html'
  end

  def append_meta_tag_keywords(keywords)
    @meta_tag_keywords = keywords
  end

  def append_meta_tag_description(description)
    @meta_tag_description = description
  end

  def append_page_title(value)
    @page_title = value
  end
end
  