class Tutorial < ActiveRecord::Base
  belongs_to :shades
  belongs_to :looks
end
