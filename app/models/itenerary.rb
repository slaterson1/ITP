class Itenerary < ActiveRecord::Base
	has_many :pitstops
	belongs_to :user
end
