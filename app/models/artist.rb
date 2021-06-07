class Artist < ApplicationRecord
  belongs_to :user
  has_many :albums
  has_one_attached :picture
  has_many :posts, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :id_facebook, presence: true, uniqueness: true
  has_many :stats
end
