# frozen_string_literal: true

# This module includes metadata-related helper methods.
module MetadataHelper
  # Link tag for touchicon_180.
  def touchicon_180
    return unless zone&.touchicon_180&.attached?

    tag :link, rel: 'apple-touch-icon', sizes: '180x180',
               href: '/apple-touch-icon.png'
  end

  # Link tag for favicon_png32.
  def favicon_png32
    return unless zone&.favicon_png32&.attached?

    tag :link, rel: 'icon', type: 'image/png', sizes: '32x32',
               href: '/favicon-32x32.png'
  end

  # Link tag for favicon_png16.
  def favicon_png16
    return unless zone&.favicon_png16&.attached?

    '<link rel="icon" type="image/png" sizes="16x16" ' \
    'href="/favicon-16x16.png">'.html_safe
  end

  # Link tag for maskicon_color.
  def maskicon_color
    return unless zone&.maskicon_color&.present?

    '<link rel="mask-icon" href="/safari-pinned-tab.svg" ' \
    "color=\"#{zone.maskicon_color}\">".html_safe
  end

  # Link tag for mstile_color.
  def mstile_color
    return unless zone&.mstile_color&.present?

    '<meta name="msapplication-TileColor" ' \
    "content=\"#{zone.mstile_color}\">".html_safe
  end

  # Link tag for chrome_themecolor.
  def chrome_themecolor
    return unless zone&.chrome_themecolor&.present?

    '<meta name="theme-color" ' \
    "content=\"#{zone.chrome_themecolor}\">".html_safe
  end
end
