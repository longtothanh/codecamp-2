module Admin::QuestionHelper
  def format_question_content(question)
    "Q: #{question.content}"
  end

  def question_action_links(question)
    link_to("Edit", edit_question_admin_test_management_path(question.test, question), class: "btn btn-warning") +
      link_to("Delete", destroy_question_admin_test_management_path(question.test, question), method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-danger")
  end
end
