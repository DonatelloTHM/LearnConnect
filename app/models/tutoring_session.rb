class TutoringSession < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tutor
end
