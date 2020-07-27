class CreateTutoringSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :tutoring_sessions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :tutor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
