class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.references :lab, foreign_key: true

      t.timestamps
    end
  end
end
