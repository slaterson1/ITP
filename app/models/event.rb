class Event < ActiveRecord::Base
  belongs_to :pitstop

  
  validates :zip, presence: true
  format: {
    with: \d\d\d\d\d
    message: "USE VALID 5-DIGIT ZIP CODE."
  }
  validates :local_datetime, presence: true
	format: {
    with: \d\d\d\d-\d\d-\d\d,
    message: "USE VALID DATE FORMAT 'YYYY-MM-DD'."
  }
end
