class Admin::DashboardsController < Admin::BaseController
  def index
    @tests = Test.all
  end

  def new_test
    @test = Test.new
  end

  def show_test
    @test = Test.find(params[:id])
    @question = Question.new(test_id: @test.id)
    @questions = Question.where(test_id: @test.id)
  end

  def create_test
    @test = Test.new(test_params)
    if Test.exists?(title: params[:title])
      flash[:alert] = "Tiêu đề bài kiểm tra đã tồn tại. Vui lòng chọn tiêu đề khác."
      redirect_to admin_root_path, notice: "Tên bài kiểm tra đã tồn tại!"
      return
    end
    if @test.save
      redirect_to admin_root_path, notice: "Bài kiểm tra đã được tạo thành công."
    end
  end

  def edit_test; end

  def update_test; end

  def destroy_test; end

  # Questions
  def new_question
  end

  def create_question
    @question = Question.new(question_params)
    if @question.save
      @answer = Answer.new
      render json: {
        html: render_to_string(partial: "new_answer", locals: { answer: @answer }, formats: [:html], layout: false)
      }
    else
      respond_to do |format|
        format.js { render partial: "error_message", locals: { errors: @question.errors.full_messages } } # Render lỗi nếu cần
        format.html { render :new }
      end
    end
  end

  def edit_question

  end

  def update_question

  end

  def destroy_question

  end

  # Answers
  def new_answer
    # @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create_answer
    contents = answer_params[:content]
    # contents.each do |content|
    #   @answer = Answer.create(content: content, question_id: answer_params[:question_id])
    # end
  end

  private

  def test_params
    params.permit(:title, :description)
  end

  def question_params
    params.require(:question).permit(:content, :test_id)
  end

  def answer_params
    params.require(:answer).permit(:question_id, content: [])
  end
end
