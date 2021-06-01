class Post < ApplicationRecord
  belongs_to :artist
  belongs_to :album, optional: true
  validates :title, :content, presence: true

  def start_time
    published_at
  end
end
