class ChangeNullForUserId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tutoring_sessions, :user_id, true
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
