# frozen_string_literal: true

json.name @zone.title
json.short_name @zone.title

icons = []
if @zone.chromeicon_192.attached?
  icons << {
    src: '/android-chrome-192x192.png',
    sizes: '192x192',
    type: 'image/png'
  }
end
if @zone.chromeicon_512.attached?
  icons << {
    src: '/android-chrome-512x512.png',
    sizes: '512x512',
    type: 'image/png'
  }
end
json.icons icons

json.theme_color @zone.chrome_themecolor if @zone.chrome_themecolor.present?
json.background_color @zone.chrome_bgcolor if @zone.chrome_bgcolor.present?
json.display @zone.chrome_display if @zone.chrome_display.present?
