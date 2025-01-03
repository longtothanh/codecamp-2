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
    binding.pry
    if @question.save
      redirect_to show_test_admin_dashboards_path(@question.test_id), notice: "Câu hỏi đã được thêm thành công."
      # render json: {
      #   partial: (render_to_string partial: 'new_answer', collection: @question, as: :question, layout: false)
      # }
    else
      redirect_to new_question_admin_dashboards_path(test_id: @question.test_id)
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
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create_answer
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to new_question_admin_dashboards_path(@answer.question)
    else
      render new_answer
    end
  end

  def ajax_answer_form
    @question = Question.new(question_params)
    # binding.pry
    # if @question.save
    #   redirect_to show_test_admin_dashboards_path(@question.test_id), notice: "Câu hỏi đã được thêm thành công."
    # else
    #   redirect_to new_question_admin_dashboards_path(test_id: @question.test_id)
    # end
    render json: {
      partial: (render_to_string partial: 'new_answer', collection: @question, as: :question, layout: false)
    }
  end

  private

  def test_params
    params.permit(:title, :description)
  end

  def question_params
    params.require(:question).permit(:content, :test_id)
  end

  def answer_params
    params.permit(:content, :correct, :question_id)
  end
end
