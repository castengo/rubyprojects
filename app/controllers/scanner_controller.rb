class ScannerController < ApplicationController

  def scan
    if params[:scan_url]
      @brand = Brand.find(params[:brand_id])
      @product = @brand.products.new

      response = HTTParty.get(params[:scan_url])
      response = Nokogiri::HTML(response)
      product_name = response.css("h1.product-name").inner_html
      product_image = response.css("img.primary-image").first['src']
      product_description = response.css("div.long-description div.tab-content").inner_html
      product_price = response.css("div.product-detail span.price-sales").inner_html
      product_no_of_shades = response.css("a.swatchanchor img").count
      @scanner_data = {
        :name => product_name,
        :image => product_image,
        :description => product_description,
        :price => product_price,
        :no_of_shades => product_no_of_shades,
        :link => params[:scan_url]
      }
      # @shades_names = []
      # response.css("a.swatchanchor img").each do |color|
      #   @shades_names.push(color['alt'])
      # end
      # @product_shades_count = @shades_names.count
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

end
