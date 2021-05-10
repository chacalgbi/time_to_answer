class Subject < ApplicationRecord
	has_many :questions, dependent: :destroy
	#Kaminari
	paginates_per 15
end
