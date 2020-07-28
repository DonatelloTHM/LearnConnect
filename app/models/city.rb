class City < ApplicationRecord
    has_many :users
    has_many :tutors 
    has_many :events, through: :users #stretch
    has_many :tutoring_sessions, through: :tutors #stretch  
    
end
