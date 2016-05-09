class ChangeDateFormatInPitstops < ActiveRecord::Migration
  	def up
    	change_column :pitstops, :date_visited, :date
  	end

  	def down
    	change_column :pitstops, :date_visited, :datetime
  	end
end
