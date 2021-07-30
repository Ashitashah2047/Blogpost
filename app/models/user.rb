class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def username
    return self.email.split('@')[0].capitalize
  end

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
end