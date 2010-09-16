class Event < ActiveRecord::Base

	#scope :future, where(:starttime > Time.now)

end