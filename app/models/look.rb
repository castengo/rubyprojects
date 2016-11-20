class Look < ActiveRecord::Base
  belongs_to :profile
  has_many :tutorials
  has_many :shades, -> { distinct }, through: :tutorials
  has_many :eye_shades, -> { filter_by_type("eye") }, through: :tutorials, source: :shade
  has_many :lip_shades, -> { filter_by_type("lip") }, through: :tutorials, source: :shade
  has_many :face_shades, -> { filter_by_type("face") }, through: :tutorials, source: :shade
  has_many :brow_shades, -> { filter_by_type("brow") }, through: :tutorials, source: :shade

  before_save :short_insta

  validates :image_url, presence: true, uniqueness: true

  def self.search(query)
    formatted_query= "%" + query.downcase + "%"
    #need to add lookup by username
    where("lower(name) LIKE ? OR lower(tags) LIKE ?", formatted_query, formatted_query)
  end

  private

    def short_insta
      full_instagram = self[:image_url]
      short = full_instagram.split('/')[4]
      if !short.nil?
        self[:image_url] = short
        caption = HTTParty.get("https://api.instagram.com/oembed?url=http://instagr.am/p/#{image_url}/&hidecaption=true&omitscript=true")['title']
        found_tags = ""
        caption.split(' ').each do |tag|
          match = tag.match /#(\w*)/
          if !match.nil?
            found_tags << " " + match[0].to_s
          end
          self[:tags] = found_tags
        end
      end
    end
end
