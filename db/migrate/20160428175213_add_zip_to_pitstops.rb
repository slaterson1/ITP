class AddZipToPitstops < ActiveRecord::Migration
  def change
  	add_column :pitstops, :zip, :integer
  end
end
