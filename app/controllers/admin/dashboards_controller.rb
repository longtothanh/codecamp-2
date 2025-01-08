class Admin::DashboardsController < Admin::BaseController
  def index
    @tests = Test.all
  end

  def new_test
    @test = Test.new
  end

  def show_test
    @test = Test.find(params[:id])
    @question = Question.new
    @questions = Question.where(test_id: @test.id)

    if @questions.present?
      @questions.each do |question|
        @answers = Answer.where(question_id: question.id)
      end
    end
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
    @question = Question.new
  end

  def create_question
    @question = Question.new(content: params[:question][:content], test_id: params[:question][:test_id])
    if @question.save
      @answer = Answer.new
      render json: {
        html: render_to_string( partial: "new_answer", locals: { answer: @answer }, formats: [ :html ], layout: false )
      }
    else
      respond_to do |format|
        format.js { render partial: "error_message", locals: { errors: @question.errors.full_messages } }
        format.html { render :new }
      end
    end
  end

  def edit_question; end

  def update_question; end

  def destroy_question; end

  # Answers
  def new_answer
    @answer = Answer.new
  end

  def create_answer
    contents = answer_params[:content]
    correct_answers = answer_params[:correct] || []

    contents.each_with_index do |content, index|
      is_correct = correct_answers[index]

      @answer = Answer.create(
        content: content,
        question_id: answer_params[:question_id],
        correct: is_correct
      )
      @answer.save
    end

    test_id = Question.find_by(id: @answer.question_id).test_id
    redirect_to show_test_admin_dashboards_path(id: test_id), notice: "Answers created successfully."
  end

  private

  def test_params
    params.permit(:title, :description)
  end

  def question_params
    params.permit(:content, :test_id)
  end

  def answer_params
    params.require(:answer).permit(:question_id, content: [], correct: [])
  end
end
