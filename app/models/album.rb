class Album < ApplicationRecord
  belongs_to :artist
  has_many_attached :cover
  has_many :posts
  validates :name, presence: true
  validates :out_at, presence: true
end
