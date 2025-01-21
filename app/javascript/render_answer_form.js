function addAnswerFunction() {
  const addAnswerButton = $("#add-answer");
  const additionalAnswerContainer = $("#additional-answers");
  let answerCount = 0;
  const maxAnswers = 3;

  addAnswerButton.on("click", function (e) {
    e.preventDefault();

    if (answerCount < maxAnswers) {
      const answerDiv = $("<div>", {
        class: "answer-container mt-3",
      });

      const newAnswerLabel = $("<label>", {
        class: "form-label mt-2 mb-2",
        text: `Nội dung câu trả lời ${answerCount + 3}`,
      });

      const newAnswerInput = $("<input>", {
        type: "text",
        name: "answer[answers][][content]",
        class: "form-control answer-input",
        placeholder: `Nội dung câu trả lời ${answerCount + 3}`,
      });

      const hiddenField = $("<input>", {
        type: "hidden",
        name: "answer[answers][][correct]",
        value: 0,
        id: `hidden-correct-answer-${answerCount + 3}`,
      });

      const radioButton = $("<input>", {
        type: "radio",
        name: "answer[answers][][correct]",
        value: 1,
        id: `correct-answer-${answerCount + 3}`,
        class: "form-check-input",
      });

      const deleteButton = $("<button>", {
        type: "button",
        class: "btn btn-danger btn-sm delete-answer my-2 mx-2",
        text: "Xóa",
      });

      deleteButton.on("click", function () {
        answerDiv.remove();
        answerCount -= 1;
        if (answerCount < maxAnswers) {
          addAnswerButton.prop("disabled", false).text("Thêm câu trả lời");
        }
      });

      // Thêm các thành phần vào div
      answerDiv.append(newAnswerLabel);
      answerDiv.append(deleteButton);
      answerDiv.append(newAnswerInput);
      answerDiv.append(hiddenField);
      answerDiv.append(radioButton);

      additionalAnswerContainer.append(answerDiv);
      answerCount += 1;
    } else {
      addAnswerButton.prop("disabled", true);
      addAnswerButton.text("Đã đạt tối đa số câu trả lời");
    }
  });

  // Validate tất cả input trước khi gửi form
  $("#submit-answers").on("click", function (e) {
    let isValid = true;
    $(".answer-input").each(function () {
      if (!validateInput($(this))) {
        isValid = false;
      }
    });

    if (!isValid) {
      e.preventDefault();
      alert("Vui lòng điền đầy đủ nội dung các câu trả lời.");
    }
  });

  // Validate input
  function validateInput(inputElement) {
    const value = inputElement.val().trim();
    const errorClass = "is-invalid";
    const validClass = "is-valid";

    if (value === "") {
      inputElement.addClass(errorClass).removeClass(validClass);
      return false;
    } else {
      inputElement.removeClass(errorClass).addClass(validClass);
      return true;
    }
  }
}


$(function () {
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
