class AddFieldsToStudent < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :date_of_birth, :date
    add_column :students, :address, :text
    add_column :students, :verified, :boolean
  end
end
