class Album < ApplicationRecord
  belongs_to :artist
  validates :name, presence: true
  validates :out_at, presence: true
end
