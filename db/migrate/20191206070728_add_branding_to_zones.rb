class AddBrandingToZones < ActiveRecord::Migration[6.0]
  def change
    add_column :zones, :chrome_themecolor, :string
    add_column :zones, :chrome_bgcolor, :string
    add_column :zones, :chrome_display, :string
    add_column :zones, :maskicon_color, :string
    add_column :zones, :mstile_color, :string
  end
end
