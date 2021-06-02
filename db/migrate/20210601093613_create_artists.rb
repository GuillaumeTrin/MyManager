class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :id_facebook
      t.references :user

      t.timestamps
    end
  end
end
