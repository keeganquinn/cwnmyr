# frozen_string_literal: true

# This module includes helper methods for use in views.
module ApplicationHelper
  JS_INCLUDES = [
    '//maps.googleapis.com/maps/api/js' \
      "?key=#{ENV['GMAPS_API_KEY']}".html_safe
  ].freeze

  # Include remote-hosted JavaScript assets.
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

  # Render Markdown text into HTML.
  def markdown(text)
    return unless text

    renderer = Redcarpet::Render::HTML.new(MARKDOWN_OPTIONS.dup)
    markdown = Redcarpet::Markdown.new(renderer, MARKDOWN_EXTENSIONS.dup)

    markdown.render(text).html_safe
  end

  # Wrap a block in the color of a Status.
  def status_color(status)
    content_tag :span, style: "color: #{status.color};" do
      yield
    end
  end

  # Default title for the current Zone, or the global default if
  # none is set.
  def default_title
    zone&.title || t(:cwnmyr)
  end

  # Title for the current page, or the default title if none is set.
  def page_title
    content_for?(:title) ? content_for(:title) : default_title
  end

  # UI options to make an HTML table searchable.
  def searchable_table
    { toggle: 'table', search: 'true', 'search-align': 'left' }
  end

  # UI options to make an HTML table row sortable.
  def sortable_row
    { sortable: 'true', sorter: 'linkSort' }
  end

  # Select from a range of recent years.
  def year_select(form, attr)
    form.input attr,
               include_blank: true, start_year: 2000, end_year: Time.now.year
  end

  # Top link for the current page.
  def top_link
    current_page?(root_path) ? browse_path : root_path
  end

  # Navigation logo image tag.
  def nav_logo_tag
    logo = root_path(format: :png, resize: '50x50', _v: zone.nav_logo_stamp)
    image_tag logo, alt: t(:logo)
  end

  # Default Zone.
  def zone
    Zone.default
  end

  # Map tag.
  def map_tag(node = nil)
    data = {
      markers:
        node ? node_path(node, format: :json) : root_path(format: :json),
      center: node ? nil : 'disco',
      zoom: (node&.zone || zone)&.zoom_default,
      max_zoom: (node&.zone || zone)&.zoom_max,
      min_zoom: (node&.zone || zone)&.zoom_min
    }

    content_tag :div, '', id: 'map', data: data
  end

  # Remote link tag.
  def post_to(label, target)
    link_to label, target, method: :post, remote: true
  end
end
