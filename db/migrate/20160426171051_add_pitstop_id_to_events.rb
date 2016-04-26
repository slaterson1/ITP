class AddPitstopIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :pitstop_id, :integer
  end
end
