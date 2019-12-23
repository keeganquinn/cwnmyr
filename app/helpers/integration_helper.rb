# frozen_string_literal: true

# This module includes helper methods for library integration.
module IntegrationHelper
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

  # Navbar collapse control.
  def navbar_collapse_control
    content_tag :button, content_tag(:span, '', class: 'navbar-toggler-icon'),
                type: 'button', class: 'navbar-toggler',
                data: { target: '#navbar-collapse', toggle: 'collapse' },
                aria_label: t(:toggle_navigation)
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
