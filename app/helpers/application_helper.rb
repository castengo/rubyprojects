module ApplicationHelper
  def instagram_html(short)
    HTTParty.get("https://api.instagram.com/oembed?url=http://instagr.am/p/#{short}/&hidecaption=true&omitscript=true")['html']
  end

  def instagram_thumbnail(short)
    HTTParty.get("https://api.instagram.com/oembed?url=http://instagr.am/p/#{short}/&hidecaption=true&omitscript=true")['thumbnail_url']
  end

  def product_short_types
    [["Eye Product", "eye"], ["Lip Product", "lip"], ["Face Product", "face"], ["Brow Product", "brow"]]
  end
end
