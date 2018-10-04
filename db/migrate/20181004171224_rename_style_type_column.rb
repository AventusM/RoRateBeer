class RenameStyleTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :styles, :type, :beer_style
  end
end
