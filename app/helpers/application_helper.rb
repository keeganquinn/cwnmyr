# frozen_string_literal: true

# This module includes helper methods for use in views.
module ApplicationHelper
  JS_INCLUDES = [
    '//maps.googleapis.com/maps/api/js' \
      "?key=#{ENV['GMAPS_API_KEY']}".html_safe
  ].freeze

  def remote_javascript_includes
    JS_INCLUDES.map do |js|
      javascript_include_tag js
    end .join.html_safe
  end

  MARKDOWN_OPTIONS = {
    filter_html: true,
    hard_wrap: true,
    link_attributes: { rel: 'nofollow', target: '_blank' },
    space_after_headers: true,
    fenced_code_blocks: true
  }.freeze

  MARKDOWN_EXTENSIONS = {
    autolink: true,
    superscript: true,
    disable_indented_code_blocks: true
  }.freeze

  def markdown(text)
    return unless text

    renderer = Redcarpet::Render::HTML.new(MARKDOWN_OPTIONS.dup)
    markdown = Redcarpet::Markdown.new(renderer, MARKDOWN_EXTENSIONS.dup)

    markdown.render(text).html_safe
  end

  def status_color(status)
    content_tag :span, style: "color: #{status.color};" do
      yield
    end
  end
end
