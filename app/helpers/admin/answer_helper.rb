module Admin::AnswerHelper
  def format_answer_content(answer)
    content_tag(:span, answer.correct? ? "#{answer.content} (Correct)" : answer.content, class: answer.correct? ? "text-success" : "")
  end

  def answer_action_links(answer)
    link_to("Edit", edit_answer_admin_test_management_path(answer.question.test, answer), class: "btn btn-warning") +
      link_to("Delete", destroy_answer_admin_test_management_path(answer.question.test, answer), method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-danger")
  end
end
