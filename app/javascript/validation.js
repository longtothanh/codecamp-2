function activateButton(selector) {
  setTimeout(() => {
    $(selector).prop("disabled", false);
  }, 100);
}

function validate(selector, message) {
  const field = $(selector);
  const value = field.val().trim();
  const errorMessage = message(value);

  if (errorMessage) {
    if (!field.siblings(".invalid-feedback").length) {
      field.addClass("is-invalid");
      field.after(`<div class="invalid-feedback">${errorMessage}</div>`);
    }
    return false;
  } else {
    field.removeClass("is-invalid");
    field.siblings(".invalid-feedback").remove();
    return true;
  }
}

$(function () {
  $("#create-test-form").on("submit", function (e) {
    e.preventDefault();
    let testFormValid = true;

    // Validate Test Title
    if (
      !validate("#test-title-input", (value) => {
        if (value === "") return "Tiêu đề không được để trống.";
        if (value.length < 5 || value.length > 100) return "Tiêu đề phải có từ 5 đến 100 ký tự.";
        return null;
      })
    ) {
      testFormValid = false;
      activateButton("#create-test-button");
    }

    // Validate Test Description
    if (
      !validate("#test-description-input", (value) => {
        if (value === "") return "Mô tả không được để trống.";
        // if (value.length < 10) return "Mô tả phải có ít nhất 10 ký tự.";
        return null;
      })
    ) {
      testFormValid = false;
      activateButton("#create-test-button");
    }

    if (testFormValid) {
      this.submit();
    }
  });

  $("#question-form").on("submit", function (e) {
    e.preventDefault();
    let questionFormValid = true;

    // Validate Question Content
    if (
      !validate("#question-content-input", (value) => {
        if (value === "") return "Nội dung câu hỏi không được để trống.";
        if (value.length < 5 || value.length > 250) return "Nội dung câu hỏi phải có từ 5 đến 250 ký tự.";
        return null;
      })
    ) {
      questionFormValid = false;
      activateButton("#create-question-button");
    }
  });
});
