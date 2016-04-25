class IteneraryController < ApplcationController
	before_action :authenticate!

	def new
		@itenerary = Itenerary.new
	end
end	 