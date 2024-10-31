class AddColunmToIncidents < ActiveRecord::Migration[7.1]
  def change
    add_reference :incidents, :user, foreign_key: true, null: false
  end
end
