class NotifiStudent < ApplicationMailer
  def send_mail(array_student, subject, content)
    @contents = content
    @subjects = subject
    @array_students = array_student
    mail to: @array_students.email,
          subject: @subjects
  end
end
