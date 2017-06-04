class Profile < ApplicationRecord
  belongs_to :account, inverse_of: :profile
  has_many :looks, dependent: :destroy

  def username
    self.account.user.username
  end

  def self.get_profile_picture(username)
    response = HTTParty.get("https://www.instagram.com/#{username}/")
    response = Nokogiri::HTML(response)
    response.css("meta").each do |meta|
      if meta['property'].to_s == "og:image"
        return meta['content']
      end
    end
  end
end
