class User < ApplicationRecord
  has_many :tutoring_sessions
  has_many :tutors, through: :tutoring_sessions
  has_many :events
  belongs_to :city
end
