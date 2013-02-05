module DeviseHelper
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
end