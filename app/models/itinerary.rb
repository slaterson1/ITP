class Itinerary < ActiveRecord::Base
	has_many :pitstops
	belongs_to :user

	validates :start_city, presence: true
	validates :user_id, presence: true
	validates :start_date, presence: true,
	format: {
    with: \d\d\d\d-\d\d-\d\d,
    message: "USE VALID DATE FORMAT 'YYYY-MM-DD'."
  }
end
