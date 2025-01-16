function addAnswerFunction() {
  const addAnswerButton = $("#add-answer");
  const additionalAnswerContainer = $("#additional-answers");
  let answerCount = 0;
  const maxAnswers = 3;

  addAnswerButton.on("click", function (e) {
    e.preventDefault();
    if (answerCount < maxAnswers) {
      // Tạo label mới
      const newAnswerLabel = $("<label>");
      newAnswerLabel.attr("class", "form-label mt-2 mb-2");
      newAnswerLabel.text(`Nội dung câu trả lời ${answerCount + 3}`);
      // Tạo mới ô input
      const newAnswerInput = $("<input>");
      newAnswerInput.attr("type", "text");
      newAnswerInput.attr("name", "answer[answers][][content]");
      newAnswerInput.attr("class", "form-control question-input");
      newAnswerInput.attr(
        "placeholder",
        `Nội dung câu trả lời ${answerCount + 3}`
      );
			// Tạo mới hidden field
      const hiddenField = $("<input>", {
        type: "hidden",
        name: "answer[answers][][correct]",
        value: 0,
        id: `hidden-correct-answer-${answerCount + 3}`,
      });
			// Tạo mới ô radio
      const radioButton = $("<input>", {
        type: "radio",
        name: "answer[answers][][correct]",
        value: 1,
        id: `correct-answer-${answerCount + 3}`,
        class: "form-check-input",
      });
			// Xử lý sự kiện click ô radio
      radioButton.on("change", function () {
				let hiddenFieldId = $(this).context.id;
        let hiddenField = $("#hidden-" + hiddenFieldId);
        if ($(this).is(":checked")) {
          hiddenField.prop("disabled", true);
        } else {
          hiddenField.prop("disabled", false);
        }
      });

			const label = $('<label>', {
				for: `correct-answer-${answerCount + 3}`,
				text: 'Câu trả lời đúng?',
				class: 'form-check-label ms-2'
			})

      // Thêm label và ô input vào container
      additionalAnswerContainer.append(newAnswerLabel);
      additionalAnswerContainer.append(newAnswerInput);
      additionalAnswerContainer.append(hiddenField, radioButton, label);
      answerCount += 1;
    } else {
      addAnswerButton.prop("disabled", true);
      addAnswerButton.text("Đã đạt tối đa số câu trả lời");
    }
  });
}

$(function () {
  // Khi thực hiện action submit để tạo question thì sẽ hiển thị answer form
  $("#question-form").on("submit", function (e) {
    e.preventDefault();
    const formData = $("#question-form").serialize();
    const actionUrl = $("#question-form").attr("action");
    $.ajax({
      url: actionUrl,
      method: "POST",
      data: formData,
      success: function (response) {
        if (response.html) {
          $("#answer-form").append(response.html);
          addAnswerFunction();
        } else {
          alert("Không nhận được dữ liệu từ server!");
        }
      },
      error: function (xhr) {
        alert("Lỗi: " + xhr.responseJSON.error.join(", "));
      },
    });
  });
});
