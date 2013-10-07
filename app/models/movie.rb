class Movie < ActiveRecord::Base
	def self.rating
		%w(G PG PG-13 NC-17 R)
	end
end
