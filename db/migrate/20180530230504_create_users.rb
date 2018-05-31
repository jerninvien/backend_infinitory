class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :invited_by_user_id, null: false
      t.references :lab, foreign_key: true

      t.timestamps
    end
  end
end
