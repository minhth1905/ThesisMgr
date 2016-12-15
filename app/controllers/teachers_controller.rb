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

  def detect
  end

  #chua phan quyen
  def index
    @per_page = 3

    @data_teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
       .where("subjects.department_id = departments.id")
       # .paginate(:page => params[:page], :per_page => 1)
    @page = 1
    start = @per_page * (@page - 1)
    if(@data_teachers.size % @per_page == 0)
      @total_page = (@data_teachers.size/@per_page)
    else
      @total_page = (@data_teachers.size/@per_page).round + 1
    end

    @teachers = @data_teachers.limit(@per_page).offset(start)

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

      @data_teachers = @data_teachers = Teacher.joins(:user,:department,:subject)
           .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
      if(params[:param])
        if(params[:param].key?("research_id"))
          @research = Research.find_by(id: params[:param][:research_id])
          @data_teachers = @data_teachers.where("teachers.id = ?",@research.teacher_id)
        end
      end
      @data_teachers = @data_teachers.where("teachers.department_id = ?",department_id)

      start = @per_page * (@page - 1)
      if(@data_teachers.size % @per_page == 0)
        @total_page = (@data_teachers.size/@per_page)
      else
        @total_page = (@data_teachers.size/@per_page).round + 1
      end

      @teachers = @data_teachers.limit(@per_page).offset(start)

      s = ""
      @teachers.each_with_index do |item,index|
        @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<tr class="headings">'
        s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
        s <<  '<th class="column-title"><a href="/teachers/info/' + item.id.to_s + '">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</a></th>'
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
      @arr.store("total_page",@total_page)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    if(params[:subject_id])
      @arr = {}
      subject_id = params[:subject_id]
      @data_teachers = @teachers_department = Teacher.joins(:user,:department,:subject)
           .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
      if(params[:param])
        if(params[:param].key?("department_id"))
          @data_teachers = @data_teachers.where("teachers.department_id = ?",params[:param][:department_id])
        end
        if(params[:param].key?("research_id"))
          @research = Research.find_by(id: params[:param][:research_id])
          @data_teachers = @data_teachers.where("teachers.id = ?", @research.teacher_id)
        end
      end
      @data_teachers = @data_teachers.where("teachers.subject_id = ?",subject_id)

      start = @per_page * (@page - 1)
      if(@data_teachers.size % @per_page == 0)
        @total_page = (@data_teachers.size/@per_page)
      else
        @total_page = (@data_teachers.size/@per_page).round + 1
      end

      @teachers = @data_teachers.limit(@per_page).offset(start)

      s = ""
      @teachers.each_with_index do |item,index|
        @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<tr class="headings">'
        s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
        s <<  '<th class="column-title"><a href="/teachers/info/' + item.id.to_s + '">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</a></th>'
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
      @arr.store("total_page",@total_page)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    @list_tree_spheres = show_tree_spheres()
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

      @data_teachers = @teachers = Teacher.joins(:user,:department,:subject)
           .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
      if(params[:param])
        if(params[:param].key?("department_id"))
          @data_teachers = @data_teachers.where("teachers.department_id = ?",params[:param][:department_id])
        end
        if(params[:param].key?("subject_id"))
          @data_teachers = @data_teachers.where("teachers.subject_id = ?",params[:param][:subject_id])
        end
      end
      @research = Research.find_by(id: research_id)
      @data_teachers = @data_teachers.where("teachers.id = ?",@research.teacher_id)

      start = @per_page * (@page - 1)
      if(@data_teachers.size % @per_page == 0)
        @total_page = (@data_teachers.size/@per_page)
      else
        @total_page = (@data_teachers.size/@per_page).round + 1
      end

      @teachers = @data_teachers.limit(@per_page).offset(start)

      s = ""
      @teachers.each_with_index do |item,index|
        @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<tr class="headings">'
        s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
        s <<  '<th class="column-title"><a href="/teachers/info/' + item.id.to_s + '">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</a></th>'
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
      @arr.store("total_page",@total_page)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    if(params[:query_string])
      @arr = {}
      query_string = params[:query_string]
      @data_teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
      if(params[:param])
        if(params[:param].key?("department_id"))
          @data_teachers = @data_teachers.where("teachers.department_id = ?",params[:param][:department_id])
        end
        if(params[:param].key?("subject_id"))
          @data_teachers = @data_teachers.where("teachers.subject_id = ?",params[:param][:subject_id])
        end
        if(params[:param].key?("research_id"))
          @research = Research.find_by(id: params[:param][:research_id])
          @data_teachers = @data_teachers.where("teachers.id = ?",@research.teacher_id)
        end
      end
      if(params[:search_by] == 'name')
        @data_teachers = @data_teachers.where("users.first_name LIKE ?","%#{query_string}%")
        @teachers = @data_teachers
      elsif(params[:search_by] == 'research')
        # @researches = Research.where("researches.name LIKE ?","%#{query_string}%")
        @array_id = Research.find_by_sql ["select id from researches where name like ?","%#{query_string}%"]
        # byebug
        # @array = []
        # @researches.each do |item|
        # arr = @array_id.split(",").map(&:to_i)
          @data_teachers = @data_teachers.where("teachers.id IN (?)",@array_id)
          # byebug
          # @array << @a
        # end
        @teachers = @data_teachers
      end


      # start = @per_page * (@page - 1)
      # if(@data_teachers.size % @per_page == 0)
      #   @total_page = (@data_teachers.size/@per_page)
      # else
      #   @total_page = (@data_teachers.size/@per_page).round + 1
      # end

      # @teachers = @data_teachers.limit(@per_page).offset(start)
      # @teachers = @data_teachers

      s = '<ul class="_search">'
      @teachers.each do |item|
        # @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
        s << '<li class="info">'
        s +=  '<a>'
        s +=    '<span><img class="image" src="/assets/img.jpg"></span>'
        s +=    '<a href="/teachers/info/' + item.id.to_s + '"><span class="head">'
        s +=      '<span>' + item.first_name.to_s + ' ' + item.last_name.to_s + '</span>'
        s +=    '<br>'
        s +=    '<span class="message">' + item.subject_name.to_s + ',' + item.department_name.to_s + '</span>'
        s +=    '</span></a>'
        s +=  '</a>'
        s <<'</li>'
      end
      s += "</ul>"
      @arr.store("teachers",s)
      respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

    if(params[:page])
      @arr = {}
      start = (params[:page].to_i - 1) * @per_page
      @teachers = Teacher.joins(:user,:department,:subject)
       .select('teachers.*,users.first_name,users.last_name,departments.id as department_id,departments.name as department_name,subjects.id as subject_id,subjects.name as subject_name')
       .where("subjects.department_id = departments.id").limit(@per_page).offset(start)
      if(@teachers.size > 0)
        s = ""
        @teachers.each_with_index do |item,index|
          @researches = Research.joins(:teacher).where("researches.teacher_id = ?",item.id)
          s << '<tr class="headings">'
          s <<  '<th class="column-title">' + (index + 1).to_s + '</th>'
          s <<  '<th class="column-title"><a href="/teachers/info/' + item.id.to_s + '">' + item.first_name.to_s + ' ' + item.last_name.to_s + '</a></th>'
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
      else
        s = "Không có dữ liệu"
      end
      @arr.store("teachers",s)
        respond_to do |format|
        format.html
        format.text {render json: @arr}
      end
    end

  end
end
