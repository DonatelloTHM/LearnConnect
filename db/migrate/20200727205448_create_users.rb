class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :address
      t.string :occupation
      t.string :grade
      t.integer :city_id

      t.timestamps
    end
  end
end
