class Shade < ActiveRecord::Base
  belongs_to :product
  has_many :tutorials
  has_many :looks, -> { distinct }, through: :tutorials

  before_save :to_hsl

  #find matching colors to specified precision
  def close_colors(hrange, srange, lrange)
    close_colors = Shade.where(h: get_h_range(h,hrange), s: get_sl_range(s,srange), l: get_sl_range(l,lrange))
  end

  def get_h_range(value,range)
    max_value = value + range > 360 ? 360 : value + range
    min_value = value - range < 0 ? 0 : value - range
    min_value..max_value
  end

  def get_sl_range(value,range)
    max_value = value + range > 100 ? 100 : value + range
    min_value = value - range < 0 ? 0 : value - range
    min_value..max_value
  end

  # Filters shade search by product type
  def self.filter_by_type(type)
    formatted_query = "%" + type.downcase + "%"
    joins(:product).where("lower(products.product_type) LIKE ?", formatted_query).uniq
  end

  # Search matches by product name, shade name, or shade finish
  def self.search(query)
    formatted_query= "%" + query.downcase + "%"
    joins(:product).where("lower(products.name) LIKE ? OR lower(shades.name) LIKE ? OR lower(finish) LIKE ? ", formatted_query, formatted_query, formatted_query)
  end

  private

    def to_hsl
      if !hex_color.nil?
        normalize_color
        rgb = {}
        match = hex_color.match /(..)(..)(..)/
        rgb[:r] = match[1].hex/255.0
        rgb[:g] = match[2].hex/255.0
        rgb[:b] = match[3].hex/255.0

        lum = sat = hue = 0
        rgb_max = rgb.values.max
        rgb_min = rgb.values.min
        #determine luminance
        lum = (rgb_min + rgb_max)/2.0
        if rgb_min != rgb_max
          # determine saturation
          d = rgb_max - rgb_min
          if lum > 0.5
            sat = d/(2.0 - rgb_max - rgb_min)
          else
            sat = d/(rgb_max + rgb_min)
          end
          # determine hue
          case rgb.key(rgb_max)
          when :r
            hue = (rgb[:g] - rgb[:b])/d
            # (rgb[:g] < rgb[:b] ? 6 : 0)
          when :g
            hue = (rgb[:b] - rgb[:r])/d + 2.0
          when :b
            hue = (rgb[:r] - rgb[:g])/d + 4.0
          end
          hue *= 60.0
          if hue < 0
            hue += 360.0
          end
        end
        self[:h] = hue.round
        self[:s] = (sat*100).round
        self[:l] = (lum*100).round
      else
        "hex is nil"
      end
    end

    def normalize_color
      if hex_color.split(',').count == 3
        hex_string = "";
        rgb_array = hex_color.split(',').map { |e| e.to_i }
        hex_string = "";
        rgb_array.each do |n|
          component = n.to_s(16)
          if n < 10
            hex_string << "0#{component}"
          else
            hex_string << component
          end
        end
        self[:hex_color] = hex_string
      end
    end

end
