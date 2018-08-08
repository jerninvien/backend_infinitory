class AddApprovedByToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :approved_by, :string, default: nil
  end
end
