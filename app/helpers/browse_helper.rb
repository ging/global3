module BrowseHelper

	def video_lecture_keynote (user)

		text=nil

		if (user.lectures!=nil) && (user.keynotes1=nil) 
			text="("
			sw=false
			if (user.lectures != nil)
				text += user.lectures
				text += "videos"
				sw=true
			end
			if (user.keynotes != nil)
				text += "," + user.keynotes
				text += "keynote"
				sw=true
			end
			if (sw)
				text += ")<br />"
			end

		end
		return text
	end

end
