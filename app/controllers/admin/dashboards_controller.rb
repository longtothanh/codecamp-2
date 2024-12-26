class Admin::DashboardsController < Admin::BaseController
  # before_action :set_test

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

  private

  def test_params
    params.permit(:title, :description)
  end

  # def set_test
  #   @test = Test.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  #   redirect_to admin_dashboard_index_path, alert: "Bài kiểm tra không tồn tại."
  # end
end
