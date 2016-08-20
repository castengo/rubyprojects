class Shade < ActiveRecord::Base
  belongs_to :product
  belongs_to :color
end
