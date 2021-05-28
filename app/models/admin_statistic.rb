class AdminStatistic < ApplicationRecord
	EVENTS = {
		total_users: "TOTAL_USERS",
		total_questions: "TOTAL_QUESTIONS"
	}


	#Métodos de Classe
	def self.set_event(evento)
		admin_statistic = AdminStatistic.find_or_create_by(event: evento)
		admin_statistic.value += 1
		admin_statistic.save
	end

	#Escopos
	scope :total_users, -> {
  	find_by_event(EVENTS[:total_users])
 	}

 	scope :total_questions, -> {
  	find_by_event(EVENTS[:total_questions])
 	}
end
