class Site::WelcomeController < SiteController
  def index
  	@questions = Question.last_answers(params[:page])
  end
end
