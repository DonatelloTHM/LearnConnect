class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starting_date
      t.datetime :end_date
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
