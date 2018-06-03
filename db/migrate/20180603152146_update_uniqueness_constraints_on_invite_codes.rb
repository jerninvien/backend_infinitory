class UpdateUniquenessConstraintsOnInviteCodes < ActiveRecord::Migration[5.2]
  def change
    remove_column :invite_codes, :redeemed_by_user_id, :integer, null: false
    add_index :invite_codes, :code, unique: true
  end
end
