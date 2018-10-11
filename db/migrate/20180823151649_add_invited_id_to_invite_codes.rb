class AddInvitedIdToInviteCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :invite_codes, :invited_id, :integer
  end
end
