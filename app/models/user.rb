class User < ApplicationRecord
  has_one :account, dependent: :destroy, inverse_of: :user

  before_create :create_account
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  private

    def create_account
      self.account = Account.new
    end
end
