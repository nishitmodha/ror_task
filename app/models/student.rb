class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true

  after_create :send_mail_to_admin
  after_save :send_verified_mail, if: :saved_change_to_verified?

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
    err = []
    CSV.foreach(file.path, headers: true) do |row|
      s = Student.new(
        name: row["name"],
        address: row["address"],
        email: row["email"],
        password: row["password"],
        date_of_birth: row["date_of_birth"]
      )
      if s.save
        StudentMailer.created_by_admin(s).deliver_now
      else
        err << s.errors.full_messages
      end
    end
    err
  end

  def send_verified_mail
    StudentMailer.student_verified_mail(self).deliver_now if self.verified
  end

  def send_mail_to_admin
    StudentMailer.send_mail_to_admin(self).deliver_now
  end
end
