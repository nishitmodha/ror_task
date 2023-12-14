class AddDefaultValueForVerifiedInStudent < ActiveRecord::Migration[7.1]
  def up
    change_column_default :students, :verified, false
  end

  def down
    change_column_default :students, :verified, nil
  end
end
