class Teacher < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :subject
  has_many :divisions
  has_many :researches


  def self.import_teacher(teacher_hash)
    teacher_value = find_by(user_id: teacher_hash["user_id"]) || new
    teacher_value.attributes = teacher_hash.to_hash.slice(*teacher_hash.to_hash.keys)
    teacher_value.save
  end
end


# if @students.length
#         User.delay.send_email(@students, params[:subject], params[:content])
#         # @students.each do |student|
#         #   NotifiStudent.send_mail(student, params[:subject], params[:content]).deliver_now
#         # end
#         flash[:success] = "Đã gửi email cho #{@students.length} sinh viên"
#         redirect_to home_path, notice: "Đã gửi email cho #{@students.length} sinh viên"
#       else
#         flash[:danger] = "Không có sinh viên nào trong trạng thái được đăng ký"
#         render :new
#       end
# notice: "Dang gui mail"
# priority: 20, run_at: 1.minutes.from_now
