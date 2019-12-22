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
  def map_tag
    data = {
      markers: root_path(format: :json),
      center: 'disco',
      zoom: zone&.zoom_default,
      max_zoom: zone&.zoom_max,
      min_zoom: zone&.zoom_min
    }

    content_tag :div, '', id: 'map', data: data
  end

  # Remote link with delete method.
  def link_del(label, target, **kwargs)
    link_to label, target, method: :delete, remote: true, **kwargs
  end

  # Link with Turbolinks disabled.
  def link_ntl(label, target, **kwargs)
    link_to label, target, data: { turbolinks: 'false' }, **kwargs
  end

  # Wrap link_to with support for Administrate::Namespace resources.
  def link_to_resource(namespace, resource)
    cls = "navigation__link navigation__link--#{nav_link_state(resource)}"
    link_to display_resource_name(resource), [namespace, resource.path],
            class: cls
  end

  # Turbolinks form wrapper.
  def turbo_form(resource, **kwargs)
    simple_form_for resource, turbolinks_form: true, **kwargs do |form|
      yield form
    end
  end

  # Turbolinks form wrapper with client validation.
  def valid_form(resource, **kwargs)
    turbo_form resource, validate: true, **kwargs do |form|
      yield form
    end
  end

  # Bootstrap button.
  def btn(label, target, type = nil, **kwargs)
    klass = ['btn']
    klass << "btn-#{type}" if type.present?
    link_to label, target, class: klass.join(' '), **kwargs
  end

  # Bootstrap button with delete method and confirmation dialog.
  def btn_del(label, target, confirm = nil, confirm_thing: nil)
    data = { confirm: confirm }
    if confirm_thing
      thing = confirm_thing.model_name.human.downcase
      data[:confirm] = t(:confirm_delete, thing: thing)
    end
    btn label, target, 'danger', method: :delete, remote: true, data: data
  end
end
