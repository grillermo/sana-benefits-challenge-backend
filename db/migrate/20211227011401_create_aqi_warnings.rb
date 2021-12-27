class CreateAQIWarnings < ActiveRecord::Migration[7.0]
  def change
    create_table :aqi_warnings do |t|
      t.references :user, null: false, index: true
      t.integer :threshold, null: false

      t.string :location, null: false
      t.string :longitude, null: false
      t.string :latitude, null: false
      t.timestamps
    end
  end
end
