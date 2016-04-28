class Pitstop < ActiveRecord::Base
  has_many :events
  belongs_to :itinerary

  validates :city, presence: true
  # validates :date_visited, presence: true,
  # format: {
  #   with: \d\d\d\d-\d\d-\d\d,
  #   message: "USE VALID DATE FORMAT 'YYYY-MM-DD'."
  # }
  validates :itinerary_id, presence: true
  validates :stop_number, presence: true
end
