class Pitstop < ActiveRecord::Base
  has_many :events
  belongs_to :itenerary
end
