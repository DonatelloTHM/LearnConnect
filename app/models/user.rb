class User < ApplicationRecord
  has_secure_password
  has_many :tutoring_sessions
  has_many :tutors, through: :tutoring_sessions
  has_many :events
  belongs_to :city

  def full_name
    self.first_name+" "+self.last_name
  end
  
end
