class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "verified", "created_at", "date_of_birth", "email",  "id", "id_value", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def active_for_authentication?
    super && self.verified # i.e. super && self.is_active
  end
  
  def inactive_message
    "Admin will verify your details soon."
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      s = Student.new(
        name: row["name"],
        address: row["address"],
        email: row["email"],
        password: row["password"],
        date_of_birth: row["date_of_birth"]
      )
      s.save
    end
  end
end
