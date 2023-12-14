class StudentMailer < ApplicationMailer
  def student_verified_mail(student)
    @student = student
    mail(to: @student.email, subject: 'Your Account has been verified')
  end

end
