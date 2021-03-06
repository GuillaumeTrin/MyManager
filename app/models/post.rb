class Post < ApplicationRecord

  attr_accessor :from
  belongs_to :artist
  belongs_to :album, optional: true
  has_one_attached :picture

  def start_time
    published_at
  end

  def publishable?
    return false if self.title.blank?
    return false if self.content.blank?
    return false unless self.picture.attached?

    true
  end

  def has_album?
    return false if self.album_id.nil?

    return true
  end

  scope :current_week, -> { where(published_at: Date.today.beginning_of_week..Date.today.next_week) }
end

