class Event < ApplicationRecord
  belongs_to :user
  has_many :event_tutors
  has_many :tutors, through: :event_tutors
end
