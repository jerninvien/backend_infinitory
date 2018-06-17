class ChangeInviteCodeToReferenceUsernameInsteadOfUserId < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :invited_by_user_id
    add_column :users, :invited_by, :string
  end

  def down
    remove_column :users, :invited_by
    add_column :users, :invited_by_user_id, :integer
  end
end
