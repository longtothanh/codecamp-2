class Admin::DashboardsController < Admin::BaseController
  def index
    @tests = Test.all
  end

  def new_test
    @test = Test.new
  end

  def show_test
    @test = Test.find(params[:id])
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
    binding.pry
    @question = Question.new(question_params)
    # if Test.exists?(title: params[:title])
    #   flash[:alert] = "Tiêu đề bài kiểm tra đã tồn tại. Vui lòng chọn tiêu đề khác."
    #   redirect_to admin_root_path, notice: "Tên bài kiểm tra đã tồn tại!"
    #   return
    # end
    if @test.save
      redirect_to admin_root_path, notice: "Bài kiểm tra đã được tạo thành công."
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
    @answer = Answer.new
  end

  def create_answer; end

  private

  def test_params
    params.permit(:title, :description)
  end

  def question_params
    params.permit(:content)
  end
end
