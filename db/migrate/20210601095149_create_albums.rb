class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :out_at
      t.references :artist

      t.timestamps
    end
  end
end
