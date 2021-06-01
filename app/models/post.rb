class Post < ApplicationRecord
  belongs_to :artist
  belongs_to :album
  validates :title, :content, presence: true
end
