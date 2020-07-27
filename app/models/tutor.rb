class Tutor < ApplicationRecord
  has_many :event_tutors
  has_many :events, through: :event_tutors
  has_many :tutoring_sessions
  has_many :users, through: :tutoring_sessions 
  belongs_to :city
end
