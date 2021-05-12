module SiteHelper
	def msg
		case params[:action]
			when 'index'
				"Últimas perguntas cadastradas"
			when 'questions'
				"Resuldado para o termo \"#{params[:term]}\"..."
			when 'subject'
				"Mostrando Questões para o assunto \"#{params[:subject]}\"..."
    	end
	end
end
