class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.references :artist, null: false, foreign_key: true
      t.date :date
      t.integer :engagement

      t.timestamps
    end
  end
end
