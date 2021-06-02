class ChangePostDateToTime < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :published_at, :datetime
  end
end
