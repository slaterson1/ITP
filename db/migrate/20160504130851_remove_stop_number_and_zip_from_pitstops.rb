class RemoveStopNumberAndZipFromPitstops < ActiveRecord::Migration
  def change
  	remove_column :pitstops, :stop_number, :integer
  	remove_column :pitstops, :zip, :integer
  end
end
