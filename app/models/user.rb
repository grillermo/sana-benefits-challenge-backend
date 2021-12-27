class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  
  has_one :aqi_warning, -> { order('created_at DESC') }

  def jwt_payload
    {
      email: email,
    }
  end
end
