# frozen_string_literal: true

# This module includes helper methods for use with Devise views.
module DeviseHelper
  def devise_error_messages!
    return '' unless devise_error_messages?

    html = <<-HTML
    <div class="error-explanation">
      <h2>#{devise_error_summary}</h2>
      <ul>#{devise_error_details}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

  def devise_error_summary
    I18n.t 'errors.messages.not_saved',
           count: resource.errors.count,
           resource: resource.class.model_name.human.downcase
  end

  def devise_error_details
    resource.errors.full_messages.map do |msg|
      content_tag :li, msg
    end .join
  end
end
