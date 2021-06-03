class AddJobIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :job_id, :string
  end
end
