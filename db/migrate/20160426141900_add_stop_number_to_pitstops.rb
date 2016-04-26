class AddStopNumberToPitstops < ActiveRecord::Migration
  def change
    add_column :pitstops, :stop_number, :integer
  end
end
