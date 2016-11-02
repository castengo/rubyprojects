class Look < ActiveRecord::Base
  belongs_to :profile
  has_many :tutorials
  has_many :shades, -> { distinct }, through: :tutorials
  has_many :eye_shades, -> { filter_by_type("eye") }, through: :tutorials, source: :shade
  has_many :lip_shades, -> { filter_by_type("lip") }, through: :tutorials, source: :shade
  has_many :face_shades, -> { filter_by_type("face") }, through: :tutorials, source: :shade
  has_many :brow_shades, -> { filter_by_type("face") }, through: :tutorials, source: :shade

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
