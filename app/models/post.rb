class Post < ApplicationRecord
  belongs_to :artist
  belongs_to :album, optional: true
  validates :title, :content, presence: true
end
