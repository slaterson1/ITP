class Pitstop < ActiveRecord::Base
  has_many :events
  belongs_to :itinerary

  validates :city, presence: true
  validates :date_visited, presence: true
  validates :itinerary_id, presence: true
  validates :stop_number, presence: true
end
