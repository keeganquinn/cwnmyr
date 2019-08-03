# frozen_string_literal: true

# Fix type on ordinal column.
class FixOrdinal < ActiveRecord::Migration[5.2]
  def change
    remove_column :statuses, :ordinal
    add_column :statuses, :ordinal, :integer
  end
end
