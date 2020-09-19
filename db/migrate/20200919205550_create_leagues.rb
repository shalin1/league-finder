class CreateLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.string :name, presence: true
      t.integer :price, presence: true, numericality: {only_integer: true}
      t.decimal :latitude, presence: true, precision: 10, scale: 6
      t.decimal :longitude, presence: true, precision: 10, scale: 6

      t.timestamps
    end
  end
end
