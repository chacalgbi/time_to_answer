class Site::WelcomeController < SiteController
  def index
  	@questions = Question.last(params[:page])
  end
end
