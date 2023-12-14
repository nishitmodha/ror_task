class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    ["address", "verified", "created_at", "date_of_birth", "email",  "id", "id_value", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
