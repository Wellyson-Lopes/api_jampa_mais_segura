class CreateCrimeTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :crime_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
