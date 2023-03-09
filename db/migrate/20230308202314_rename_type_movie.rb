class RenameTypeMovie < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :type, :category
  end
end
