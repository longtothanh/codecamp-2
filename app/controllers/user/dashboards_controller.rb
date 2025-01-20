class User::DashboardsController < User::BaseController
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions.includes(:answers)
  end

  def submit
    submitted_answers = params[:test]
    @score = 0;
    submitted_answers.each do |question_id, answer_id|
      question = Question.find(question_id.to_i)
      question.answers.each do |answer|
        if answer.id == answer_id["answer_id"].to_i && answer.correct
          @score += 1
        end
      end
    end
    @total_questions = Question.where(test_id: params[:id]).count
    render json: {
      html: render_to_string( partial: "result", locals: { total_questions: @total_questions, score: @score }, formats: [ :html ], layout: false )
    }
  end
end
