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
    @correct_answers = 0;
    submitted_answers.each do |question_id, answer_id|
      question = Question.find(question_id.to_i)
      question.answers.each do |answer|
        if answer.id == answer_id["answer_id"].to_i && answer.correct
          @correct_answers += 1
        end
      end
    end
    @total_questions = submitted_answers.keys.size
    @score = ((@correct_answers.to_f / @total_questions) * 10).round(2)
    render json: {
      html: render_to_string( partial: "result", locals: { total_questions: @total_questions, score: @score }, formats: [ :html ], layout: false )
    }
  end
end
