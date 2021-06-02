class Album < ApplicationRecord
  belongs_to :artist
  has_one_attached :cover
  validates :name, presence: true
  validates :out_at, presence: true
end
