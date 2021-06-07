class Stat < ApplicationRecord
  belongs_to :artist
  validates :date, uniqueness: { scope: :artist }
end
