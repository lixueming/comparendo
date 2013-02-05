module ApplicationHelper
  def link_to_company(company, html_options={}, &block)
    if block_given?
      link_to(capture(&block), url_to_company(company), html_options)
    else
      link_to(company.name, url_to_company(company), html_options)
    end
  end

  def url_to_company(company)
    require 'code_extensions.rb'
    url_for({:controller => :company, :action => :show, 
      :region => CodeExtensions::PARSE_FOR_PATH.(company.region_name), 
      :uid => company.uid, :company => CodeExtensions::PARSE_FOR_PATH.(company.name)
    })
  end

  def devise_error_messages!
    return "" if resource.errors.empty?

    message = resource.errors.full_messages[0]

    html = <<-HTML
    <div class="alert alert-error">
      #{message}
    </div>
    HTML

    html.html_safe
  end

  def meta_tag_description
    @meta_tag_description.insert(0,". ") if @meta_tag_description
     raw "<meta name=\"description\" content=\"#{I18n.t(:default_meta_tag_description)}#@meta_tag_description\" />"
  end

  def meta_tag_keywords
    @meta_tag_keywords.insert(0, ", ") if @meta_tag_keywords
    raw "<meta name=\"keywords\" content=\"#{I18n.t(:default_meta_tag_keywords)}#@meta_tag_keywords\" />"
  end

  def page_title
    @page_title += " | " if @page_title
    raw "<title>#@page_title#{I18n.t(:generic_title)}</title>"
  end
end
