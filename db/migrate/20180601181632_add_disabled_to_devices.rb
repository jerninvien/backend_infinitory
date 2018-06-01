class AddDisabledToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :disabled, :boolean, null: false, default: false
  end
end
