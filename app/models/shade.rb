class Shade < ActiveRecord::Base
  belongs_to :product
  belongs_to :color

  before_save :normalize_color

  private

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
