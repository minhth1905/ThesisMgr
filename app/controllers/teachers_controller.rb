class TeachersController < ApplicationController
  before_action :user_signin
  def show
  end
  def edit
    @check = params[:check].to_i
    @user = User.find_by(id: params[:id])
    @teacher = Teacher.find_by(user_id: @user.id)
  end
  def update
    @user = User.find_by(id: params[:id])
    @teacher = Teacher.find_by(user_id: @user.id)
    if @user.update_attributes(first_name: params[:first_name],
     last_name: params[:last_name], birthday: params[:birthday],
     country: params[:country], province: params[:province], distric: params[:distric],
     town: params[:town]) && @teacher.update_attributes(description: params[:description])
      flash[:success] = "Cập nhật thành công"
      if params[:check].to_i == 1
        redirect_to new_updateinfor_path(check: 1)
      else

        redirect_to home_path(check: 1)
      end
    else
      render :edit
    end
  end

  #chua phan quyen
  def index
    @per_page = 2
    @page = 1
    start = @per_page * (@page - 1)
    @teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
       .where("subjects.department_id = departments.id").limit(@per_page).offset(start)

       # .paginate(:page => params[:page], :per_page => 1)
    @total_page = (@teachers.size/@per_page) + 1

    @teachers.each do |item|
      @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
      item.researches << @researches
    end

    @departments = Department.all
    if(params[:department_id])
      @arr = {}
      department_id = params[:department_id]
      @department = Department.find_by(id: department_id)

      @subject_belong_department = @department.subjects
      @arr.store("subjects",@subject_belong_department)

      @teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
       .where("teachers.department_id = ?",department_id)
      s = ""
      @teachers.each_with_index do |item,index|
        @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<tr class="headings">'
        s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
        s <<  '<th class="column-title">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</th>'
        s <<  '<th class="column-title">Học vị </th>'
        s <<  '<th class="column-title">' + item.subject_name.to_s + ',' + item.department_name.to_s + '</th>'
        s <<  '<th class="column-title no-link last"><span class="nobr">'
            @researches.each do |item_research|
            s <<  '<p>' + item_research.name.to_s + '</p>'
            end
        s <<  '</span>'
        s <<  '</th>'
        s <<'</tr>'
      end
      @arr.store("teachers",s)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    if(params[:subject_id])
      @arr = {}
      subject_id = params[:subject_id]
      if(params[:param])
        if(params[:param].key?("department_id"))
          @teachers = Teacher.joins(:user,:department,:subject)
           .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
           .where("teachers.department_id = ? AND teachers.subject_id = ?",params[:param][:department_id],subject_id)
        else
          @teachers = Teacher.joins(:user,:department,:subject)
         .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
         .where("teachers.subject_id = ?",subject_id)
        end
      end
      # @teachers = Teacher.joins(:user,:department,:subject)
      #  .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
      #  .where("teachers.subject_id = ?",subject_id)
      s = ""
      @teachers.each_with_index do |item,index|
        @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<tr class="headings">'
        s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
        s <<  '<th class="column-title">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</th>'
        s <<  '<th class="column-title">Học vị </th>'
        s <<  '<th class="column-title">' + item.subject_name.to_s + ',' + item.department_name.to_s + '</th>'
        s <<  '<th class="column-title no-link last"><span class="nobr">'
            @researches.each do |item_research|
            s <<  '<p>' + item_research.name.to_s + '</p>'
            end
        s <<  '</span>'
        s <<  '</th>'
        s <<'</tr>'
      end
      @arr.store("teachers",s)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    @spheres = Sphere.all
    @list_tree_spheres = show_tree(@spheres,0,0)
    if(params[:sphere_id])
      @arr = {}
      sphere_id = params[:sphere_id]

      @research_belong_sphere = Research.find_by_sql ["select r.* from researches r join searchspheres s on r.id = s.research_id where s.sphere_id = ?",sphere_id]
      @arr.store("researches",@research_belong_sphere)

      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    if(params[:research_id])
      @arr = {}
      research_id = params[:research_id]
      if(params[:param])
        if(params[:param].key?("department_id"))
          @teachers = Teacher.joins(:user,:department,:subject)
           .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
           .where("teachers.department_id = ? AND teachers.subject_id = ?",params[:param][:department_id],subject_id)
        else
          @teachers = Teacher.joins(:user,:department,:subject)
         .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
         .where("teachers.subject_id = ?",subject_id)
        end
      end
      @research = Research.find_by(id: research_id)
      @teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
       .where("teachers.id = ?",@research.teacher_id)
      s = ""
      @teachers.each_with_index do |item,index|
        @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<tr class="headings">'
        s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
        s <<  '<th class="column-title">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</th>'
        s <<  '<th class="column-title">Học vị </th>'
        s <<  '<th class="column-title">' + item.subject_name.to_s + ',' + item.department_name.to_s + '</th>'
        s <<  '<th class="column-title no-link last"><span class="nobr">'
            @researches.each do |item_research|
            s <<  '<p>' + item_research.name.to_s + '</p>'
            end
        s <<  '</span>'
        s <<  '</th>'
        s <<'</tr>'
      end
      @arr.store("teachers",s)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    if(params[:query_string])
      @arr = {}
      query_string = params[:query_string]
      # if(params[:param])
      #   if(params[:param].key?("department_id"))
      #     @teachers = Teacher.joins(:user,:department,:subject)
      #      .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
      #      .where("teachers.department_id = ? AND teachers.subject_id = ?",params[:param][:department_id],subject_id)
      #   else
      #     @teachers = Teacher.joins(:user,:department,:subject)
      #    .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
      #    .where("teachers.subject_id = ?",subject_id)
      #   end
      # end
      @teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
       .where("users.last_name LIKE ?","%#{query_string}%")
      s = ""
      @teachers.each_with_index do |item,index|
        @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<tr class="headings">'
        s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
        s <<  '<th class="column-title">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</th>'
        s <<  '<th class="column-title">Học vị </th>'
        s <<  '<th class="column-title">' + item.subject_name.to_s + ',' + item.department_name.to_s + '</th>'
        s <<  '<th class="column-title no-link last"><span class="nobr">'
            @researches.each do |item_research|
            s <<  '<p>' + item_research.name.to_s + '</p>'
            end
        s <<  '</span>'
        s <<  '</th>'
        s <<'</tr>'
      end
      @arr.store("teachers",s)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

  end
end
