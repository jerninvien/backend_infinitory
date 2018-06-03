class RemoveNotNotFromInvitedByUserIdOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :invited_by_user_id, true)
  end
end
