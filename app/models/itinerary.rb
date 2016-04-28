class Itinerary < ActiveRecord::Base
	has_many :pitstops
	belongs_to :user

	validates :zip, presence: true
	validates :user_id, presence: true
	validates :start_date, presence: true,
	format: {
    with: /\d{4}-\d{2}-\d{2}/,
    message: "USE VALID DATE FORMAT 'YYYY-MM-DD'."
  }
	validates :travel_days, presence: true
end
