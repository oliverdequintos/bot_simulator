class BotAction
	def initialize(action, x, y, f)
		@action = action
		@x = x.to_i
		@y = y.to_i
		@face = f
	end

	def process!
		if @action == "MOVE"			
			move
		elsif @action == "LEFT" || @action == "RIGHT"			
			send(@action)			
		end
	end

	def move
		case @face
		when "NORTH"			
			@y = @y + 1 if @y < 4
		when "EAST"
			@x = @x + 1 if @x < 4
		when "SOUTH"
			@y = @y - 1 if @y > 1
		when "WEST"
			@x = @x - 1 if @x > 1
		end

		return "#{@x}, #{@y}, #{@face}"
	end
	
	private

		def LEFT
			case @face
			when "NORTH"
				@face = 'WEST'
			when "EAST"
				@face = 'NORTH'
			when "SOUTH"
				@face = 'EAST'
			when "WEST"
				@face = 'SOUTH'
			end

			return "#{@x}, #{@y}, #{@face}"
		end

		def RIGHT
			case @face
			when "NORTH"
				@face = 'EAST'
			when "EAST"
				@face = 'SOUTH'
			when "SOUTH"
				@face = 'WEST'
			when "WEST"
				@face = 'NORTH'
			end

			return "#{@x}, #{@y}, #{@face}"
		end
end
