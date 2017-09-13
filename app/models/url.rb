require 'securerandom'
require 'uri'

class Url < ApplicationRecord
  before_create :shorten
  validates :ori_url, presence: true
  validate :url_format


	def shorten
    self.short_url = SecureRandom.hex(5)
  end

  def url_format
    begin
      errors.add(:url, "Invalid url") unless URI(self.ori_url).is_a?(URI::HTTP)
    rescue URI::InvalidURIError
      errors.add(:url, "Invalid url")
    end
  end
end
