class Event < ActiveRecord::Base
  belongs_to :pitstop

  validates :local_datetime, presence: true,
	format: {
    with: /\d{4}-\d{2}-\d{2}/,
    message: "USE VALID DATE FORMAT 'YYYY-MM-DD'."
  }
end
