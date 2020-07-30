class City < ApplicationRecord
    has_many :users
    has_many :tutors 
    has_many :events, through: :users #stretch
    has_many :tutoring_sessions, through: :tutors #stretch  
    
    
    def state_code
        state=CS.states(:us).key(self.state)
        state[0..-1].upcase
    end
end
