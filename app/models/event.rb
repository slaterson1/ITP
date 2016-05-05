class Event < ActiveRecord::Base
  belongs_to :pitstop

  validates :game_number, presence: true

  # def update_from_seatgeek
  # 	api = SeatGeek.new
  # 	data = api.get_game_number(self.game_number)
  # 	self.update(foo: data["foo"])
  # end
end
