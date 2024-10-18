class CreateIncidents < ActiveRecord::Migration[7.1]
  def change
    create_table :incidents do |t|
      t.references :crime_type, null: false, foreign_key: true  # Relacionamento com a tabela crime_types
      t.decimal :latitude, precision: 10, scale: 6, null: false  # Latitude do local do crime
      t.decimal :longitude, precision: 10, scale: 6, null: false  # Longitude do local do crime
      t.string :city, null: false  # Cidade onde ocorreu o crime
      t.string :district  # Bairro onde ocorreu o crime
      t.string :address  # Rua onde ocorreu o crime
      t.date :date, null: false  # Data da ocorrência
      t.time :time # Hora da ocorrência
      t.boolean :disabled, default: false  # Flag para desativar a ocorrência em caso de trote
      t.text :observations  # Observações adicionais sobre a ocorrência
      t.string :vehicle_description  # Descrição do veículo utilizado no crime (substitui 'vehicle')
      t.string :weapon_type  # Tipo de arma utilizada (substitui 'weapon')
      t.integer :number_of_individuals  # Quantidade de criminosos envolvidos
      t.string :target  # Alvo da ocorrência (substitui 'victim_is_person')

      t.timestamps
    end
  end
end
