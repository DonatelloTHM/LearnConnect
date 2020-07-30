class User < ApplicationRecord
  has_secure_password
  has_many :tutoring_sessions
  has_many :tutors, through: :tutoring_sessions
  has_many :events
  belongs_to :city
  has_one_attached :photo


  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, length: { in: 6..10 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true
  validates :occupation, presence: true
  validates :grade, presence: true
  validates :address, presence: true
  




  def city_id=(arr)
    city=City.find_or_create_by(name: arr[:name],state: arr[:state])
    self.city=city
  end

  def full_name
    self.first_name+" "+self.last_name
  end



end
