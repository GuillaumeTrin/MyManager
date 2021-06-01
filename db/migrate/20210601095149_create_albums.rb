class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :out_at
      t.artist :references

      t.timestamps
    end
  end
end
