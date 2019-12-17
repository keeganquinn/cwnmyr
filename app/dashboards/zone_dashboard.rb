# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Zone model.
class ZoneDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    code: Field::String,
    name: Field::String,
    body: Field::Text,
    nav_logo: Field::ActiveStorage,
    chromeicon_192: Field::ActiveStorage,
    chromeicon_512: Field::ActiveStorage,
    chrome_themecolor: Field::String,
    chrome_bgcolor: Field::String,
    chrome_display: Field::String,
    favicon_ico: Field::ActiveStorage.with_options(url_only: true),
    favicon_png16: Field::ActiveStorage,
    favicon_png32: Field::ActiveStorage,
    maskicon_color: Field::String,
    maskicon_svg: Field::ActiveStorage.with_options(url_only: true),
    mstile_150: Field::ActiveStorage,
    mstile_color: Field::String,
    touchicon_180: Field::ActiveStorage,
    nodes: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[code name].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    code name body nav_logo chromeicon_192 chromeicon_512 chrome_themecolor
    chrome_bgcolor chrome_display favicon_ico favicon_png16 favicon_png32
    maskicon_color maskicon_svg mstile_150 mstile_color touchicon_180 nodes
    created_at updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    code name body nav_logo chromeicon_192 chromeicon_512 chrome_themecolor
    chrome_bgcolor chrome_display favicon_ico favicon_png16 favicon_png32
    maskicon_color maskicon_svg mstile_150 mstile_color touchicon_180
  ].freeze

  # Display representation of the resource.
  def display_resource(zone)
    "Zone ##{zone.to_param}"
  end
end
