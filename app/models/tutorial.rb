class Tutorial < ActiveRecord::Base
  belongs_to :shade
  belongs_to :look

  validates :shade_id, presence: true
  validates :look_id, presence: true
end
