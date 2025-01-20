$(function () {
  $("#do_test").on("submit", function (e) {
    e.preventDefault();
    let isValid = true;

    $(".question-container").each(function () {
      const hasAnswer = $(this).find("input[type=radio]:checked").length > 0;

      if (!hasAnswer) {
        isValid = false;
        $(this).addClass("border border-danger");
      } else {
        $(this).removeClass("border border-danger");
      }
    });

    if (!isValid) {
      alert("Vui lòng trả lời tất cả các câu hỏi trước khi nộp bài!");
      setTimeout(() => {
        $("#submit-do-test").prop("disabled", false).focus();
      }, 100);
      return;
    }

    const formData = $("#do_test").serialize();
    const actionUrl = $("#do_test").attr("action");

    $.ajax({
      url: actionUrl,
      method: "POST",
      data: formData,
      success: function (response) {
        if (response.html) {
          $("#result").append(response.html);

          $("#do_test").parent().hide();
        } else {
          alert("Không nhận được dữ liệu từ server!");
        }
      },
      error: function (xhr) {
        alert("Lỗi: " + (xhr.responseJSON?.error?.join(", ") || "Lỗi server."));
      },
    });
  });
});
