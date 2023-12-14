class StudentMailer < ApplicationMailer
  def student_verified_mail(student)
    @student = student
    mail(to: @student.email, subject: 'Your Account has been verified')
  end

  def created_by_admin(student)
    @student = student
    mail(to: @student.email, subject: 'Your Account has been created by Admin')
  end

  def send_mail_to_admin(student)
    emails = AdminUser.pluck(:email)
    @student = student
    mail(to: emails, subject: 'Student has been created')
  end

end
