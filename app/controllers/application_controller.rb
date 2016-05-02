class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

  def current_user
  	token = request.headers["X-Auth-Token"]
  	if token
  		User.find_by(auth_token: token)
  	end
  end

  def authenticate!
  	unless current_user
  		render json: { errors: "YOU MUST LOG IN FIRST!" },
  			status: :unauthorized
  	end
  end

  def real_date?(year, month, day)
    r1 = false
    r2 = false
    r3 = false
    result = false
    year.between?(2016, 2100)? r1 = true : r1 = false
    thirty_day = Set.new([4, 6, 9, 11])
    month.between?(1, 12)? r2 = true : r2 = false
    if month == 2 && year % 4 == 0
      day < 30? r3 = true : r3 = false
    elsif month == 2 && year % 4 != 0
      day < 29? r3 = true : r3 = false
    elsif thirty_day.include?(month)
      day < 31? r3 = true : r3 = false
    else
      day < 32? r3 = true : r3 = false
    end
    (r1 == true && r2 == true && r3 == true)? result = true : result = false
    result
  end

  def advance_a_day(previous_date)
    d = Date.parse(previous_date)
    new_day = d.day + 1
    new_date = ""
    if !real_date?(d.year, d.month, new_day)
      new_day = 1
      new_month = d.month + 1
      new_date = "#{d.year}-#{new_month}-#{new_day}"
      if !real_date?(d.year, new_month, new_day)
        new_year = d.year + 1
        new_date = "#{new_year}-#{new_month}-#{new_day}"
      end
    else
      new_date = "#{d.year}-#{d.month}-#{new_day}"
    end
    new_date
  end
  
  rescue_from ActiveRecord::RecordNotFound do |error|
       render json: { error: "No such object: #{error.message} " },
      status: :not_found
  end
end
