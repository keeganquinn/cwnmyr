class RemovePaperclipColumns < ActiveRecord::Migration[5.2]
  def change
    drop_table :logos

    remove_column :nodes, :logo_file_name, :string
    remove_column :nodes, :logo_content_type, :string
    remove_column :nodes, :logo_file_size, :integer
    remove_column :nodes, :logo_updated_at, :datetime
  end
end
