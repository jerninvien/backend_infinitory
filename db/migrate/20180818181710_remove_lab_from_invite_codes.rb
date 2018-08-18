class RemoveLabFromInviteCodes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :invite_codes, :lab, foreign_key: true
  end
end
