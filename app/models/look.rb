class Look < ActiveRecord::Base
  has_and_belongs_to_many :shades
  belongs_to :profile

  before_save :short_insta

  validates :image_url, presence: true, uniqueness: true

  private

    def short_insta
      full_instagram = self[:image_url]
      short = full_instagram.split('/')[4]
      if !short.nil?
        self[:image_url] = short
      end
    end
end
