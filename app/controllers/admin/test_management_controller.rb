class Admin::TestManagementController < ApplicationController
  before_action :set_test, only: %i[show edit update destroy]
  before_action :set_question, only: %i[edit_question update_question destroy_question]
  before_action :set_answer, only: %i[edit_answer update_answer destroy_answer]

  include TestHelper
  include QuestionHelper
  include AnswerHelper

  # Actions for Tests
  def index; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  # Actions for Questions
  def new_question; end

  def create_question; end

  def edit_question; end

  def update_question; end

  def destroy_question; end

  # Actions for Answers
  def new_answer; end

  def create_answer; end

  def edit_answer; end

  def update_answer; end

  def destroy_answer; end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :description)
  end

  def question_params
    params.require(:question).permit(:content)
  end

  def answer_params
    params.require(:answer).permit(:content, :correct)
  end

end
