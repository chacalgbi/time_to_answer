class Site::SearchController < SiteController
	def questions
		@questions = Question.search_answers(params[:page], params[:term])
	end
end
