class UpdateColumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :photos, :date, :data
  end
end
