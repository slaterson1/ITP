class IteneraryController < ApplicationController
	before_action :authenticate!

	def new
		@itenerary = Itenerary.new
	end
end	 