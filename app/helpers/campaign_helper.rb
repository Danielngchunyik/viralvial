module CampaignHelper

	def time_diff(startTime, endTime)
	  seconds_diff = (startTime - endTime).to_i.abs

	  hours = seconds_diff / 3600
	  seconds_diff -= hours * 3600

	  minutes = seconds_diff / 60
	  seconds_diff -= minutes * 60

	  seconds = seconds_diff

	  "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
	end
	
	def time_remaining(endTime)
		# timeDifference = Time.now - endTime
		# if timeDifference > 3.weeks
		# 	time_remaining = time_ago_in_words(endTime)
		# elsif timeDifference > 1.weeks and timeDifference <= 3.weeks
		# 	time_remaining = time_ago_in_words(endTime)
		# elsif timeDifference <= 1.weeks and timeDifference > 24.hours
		# 	time_remaining = time_ago_in_words(endTime)
		# else timeDifference <= 24.hours
		# 	time_remaining = time_diff(Time.now, endTime)
		# time_remaining
		time_ago_in_words(endTime)
	end
end