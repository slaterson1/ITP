class CreateIteneraries < ActiveRecord::Migration
  def change
    create_table :iteneraries do |t|
      t.date :start_date
      t.string :start_city
      t.integer :travel_days

      t.timestamps null: false
    end
  end
end
