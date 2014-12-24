module ApplicationHelper
	def title

		base_title = "Ruby on Rilas Tutorial Sample App"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{title}"
		end
	end
	

end
