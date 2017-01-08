class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :games
  has_many :friends
  #:confirmable
  include DeviseTokenAuth::Concerns::User
end
