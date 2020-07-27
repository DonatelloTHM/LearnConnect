class CreateTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :tutors do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :subject
      t.integer :age
      t.string :education_level
      t.integer :city_id

      t.timestamps
    end
  end
end
