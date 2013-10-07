class Movie < ActiveRecord::Base
	def self.rating
		ratings = []
		Movie.all.each do |movie|
			unless ratings.include?(movie.rating)
				ratings << movie.rating
			end
		end
		if ratings.include?("NC-17")
			ratings.delete("NC-17")
			ratings.sort!
			ratings << ("NC-17")
			return ratings
		else
			ratings.sort! 
			return ratings
		end
	end
end
