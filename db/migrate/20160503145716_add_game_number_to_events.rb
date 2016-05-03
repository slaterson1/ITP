class AddGameNumberToEvents < ActiveRecord::Migration
  def change
    add_column :events, :game_number, :integer
  end
end
