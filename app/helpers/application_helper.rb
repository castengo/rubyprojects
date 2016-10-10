module ApplicationHelper
  def get_embedded_instagram(short)
    HTTParty.get("https://api.instagram.com/oembed?url=http://instagr.am/p/#{short}/?hidecaption=true&omitscript=true")['html']
  end
end
