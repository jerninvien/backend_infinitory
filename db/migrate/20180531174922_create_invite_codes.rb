class CreateInviteCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_codes do |t|
      t.references :user, foreign_key: true
      t.references :lab, foreign_key: true
      t.integer :code, null: false
      t.integer :redeemed_by_user_id

      t.timestamps
    end
  end
end
