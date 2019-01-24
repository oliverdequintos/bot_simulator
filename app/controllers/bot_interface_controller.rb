class BotInterfaceController < ApplicationController
  def index
  end

  def perform
  	if valid_movements? && placed?
	 		new_location = ::BotAction.new(upcase_input, params[:x_loc], params[:y_loc], params[:f_loc]).process!.split(',')
	 		@x_loc = new_location[0]
	 		@y_loc = new_location[1]
	 		@f_loc = new_location[2].strip
		elsif upcase_input.include?("PLACE")
			new_location = placed_input = upcase_input.gsub("PLACE", "").strip.split(',')
			@x_loc = new_location[0]
			@y_loc = new_location[1]
			@f_loc = new_location[2]
		elsif upcase_input == "REPORT"
			@x_loc = params[:x_loc]
			@y_loc = params[:y_loc]
			@f_loc = params[:f_loc]
		else
			@x_loc = nil
			@y_loc = nil
			@f_loc = nil
			@movement = 4
		end

		movement_in_number
  end

  private
  	def valid_movements?
  		upcase_input == "MOVE" || 
	 		upcase_input == "LEFT" || 
	 		upcase_input == "RIGHT"
  	end

  	def placed?
  		params[:x_loc].present? && 
  		params[:y_loc].present? && 
  		params[:f_loc].present?
  	end

  	def validate_place_value
  		placed_input = upcase_input.gsub(" ", ",").split(',')
  		placed_input[0] == "PLACE" && 
  		(placed_input[1].to_i >= 0 && placed_input[1].to_i <= 4) &&
  		(placed_input[2].to_i >= 0 && placed_input[2].to_i <= 4)
  	end

  	# Created this method because of some issue that String is not accessible on perform.js.erb
  	def movement_in_number
  		case upcase_input
  		when "MOVE"
  			if validate_presence_of_initial_place_value
  				@movement = 0
	  		else
	  			@movement = 4
	  		end
  		when "LEFT"
  			if validate_presence_of_initial_place_value
  				@movement = 1
	  		else
	  			@movement = 4
	  		end
  		when "RIGHT"
  			if validate_presence_of_initial_place_value
  				@movement = 2
	  		else
	  			@movement = 4
	  		end
  		when "REPORT"
  			if validate_presence_of_initial_place_value
	  			@movement = 5
	  		else
	  			@movement = 4
	  		end
  		else
  			if validate_place_value
  				@movement = 3
				else
					@movement = 4
  			end
  		end
  	end

  	def validate_presence_of_initial_place_value
  		params[:x_loc].present? && params[:y_loc].present?
  	end

  	def upcase_input
  		params[:robot_input].upcase
  	end
end
