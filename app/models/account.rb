class Account < ActiveRecord::Base
  belongs_to :user, inverse_of: :account
  has_one :profile, dependent: :destroy, inverse_of: :account

end
