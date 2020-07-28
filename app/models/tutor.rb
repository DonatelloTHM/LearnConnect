class Tutor < ApplicationRecord
  has_secure_password
  has_many :event_tutors
  has_many :events, through: :event_tutors
  has_many :tutoring_sessions
  has_many :users, through: :tutoring_sessions 
  belongs_to :city
  has_one_attached :photo


  def city_id=(arr)

    city=City.find_or_create_by(name: arr[:name],state: arr[:state])
    self.city=city
  end

  def self.get_subjects
    Tutor.all.map{|subject| subject.subjects.downcase}.join(',').split(/[^\w-]+/).uniq
  end


  def full_name
    self.first_name+" "+self.last_name
  end
end
