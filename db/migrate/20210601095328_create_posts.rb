class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :image
      t.boolean :published
      t.date :published_at
      t.references :artist
      t.references :album

      t.timestamps
    end
  end
end
