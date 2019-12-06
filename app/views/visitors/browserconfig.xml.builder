# -*- ruby -*-
# frozen_string_literal: true

xml.instruct!

xml.browserconfig do
  xml.msapplication do
    xml.tile do
      if @zone.mstile_150.attached?
        xml.square150x150logo src: '/mstile-150x150.png'
      end

      xml.TileColor @zone.mstile_color if @zone.mstile_color.present?
    end
  end
end
