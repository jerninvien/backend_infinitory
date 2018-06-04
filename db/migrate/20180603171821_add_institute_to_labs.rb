class AddInstituteToLabs < ActiveRecord::Migration[5.2]
  def change
    add_column :labs, :institute, :string
  end
end
