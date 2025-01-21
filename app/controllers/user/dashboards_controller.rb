class User::DashboardsController < User::BaseController
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions.includes(:answers)
  end

  def submit
    test = Test.find(params[:id])

    user_exam = current_user.user_exams.find_or_create_by(test_id: test.id) do |ue|
      ue.start_time = Time.current
    end

    submitted_answers = params[:test]
    @correct_answers = 0;

    submitted_answers.each do |question_id, answer_id|
      question = Question.find(question_id.to_i)
      question.answers.each do |answer|
        if answer.id == answer_id["answer_id"].to_i && answer.correct
          @correct_answers += 1
        end
      end
      answer = question.answers.find_by(id: answer_id["answer_id"].to_i)

      if user_exam.user_answers.exists?(question_id: question.id)
        user_answer = user_exam.user_answers.find_by(question_id: question.id)
        user_answer.update!(
          answer_id: answer&.id,
          times: user_answer.times + 1
        )
      else
        user_exam.user_answers.create!(
          question_id: question.id,
          answer_id: answer&.id,
          times: 1
        )
      end
    end

    @total_questions = submitted_answers.keys.size
    score = ((@correct_answers.to_f / @total_questions) * 10).round(2)
    user_exam.update(score: score, submit_time: Time.current)

    @user_exam = user_exam
    @user_answers = user_exam.user_answers

    render json: {
      html: render_to_string( partial: "result", locals: { total_questions: @total_questions, score: @user_exam.score }, formats: [ :html ], layout: false )
    }
  end
end
