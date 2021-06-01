class Artist < ApplicationRecord
  belongs_to :user,
  has_many :albums,
  has_many :posts,
  validates :name, presence: true, uniqueness: true
end
