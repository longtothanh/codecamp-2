module Admin::TestHelper
  def format_test_title(test)
    "#{test.title} - #{test.description}"
  end

  def test_action_links(test)
    link_to("Edit", edit_admin_test_management_path(test), class: "btn btn-warning") +
      link_to("Delete", admin_test_management_path(test), method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-danger")
  end
end
