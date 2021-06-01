class ChangeColumnIdFacebookToArtist < ActiveRecord::Migration[6.0]
  def up
    change_column :artists, :id_facebook, :string
  end

  def down
    change_column :artists, :id_facebook, 'integer USING CAST(id_facebook AS integer)'
  end
end
