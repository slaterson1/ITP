class Pitstop < ActiveRecord::Base
  has_many :events
  belongs_to :itinerary

  validates :zip, presence: true
  validates :date_visited, presence: true,
  format: {
    with: /\d{4}-\d{2}-\d{2}/,
    message: "USE VALID DATE FORMAT 'YYYY-MM-DD'."
  }
  validates :itinerary_id, presence: true
  validates :stop_number, presence: true
end
