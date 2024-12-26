document.addEventListener("DOMContentLoaded", function () {
  const addAnswerButton = document.getElementById("add-answer");
  const additionalAnswersContainer = document.getElementById("additional-answers");
  let answerCount = 0;
  const maxAnswers = 3;

  if (addAnswerButton) {
    addAnswerButton.addEventListener("click", function () {
      if (answerCount < maxAnswers) {
        // Tạo label mới
        const newAnswerLabel = document.createElement("label");
        newAnswerLabel.textContent = `Nội dung câu trả lời ${answerCount + 3}`;
        newAnswerLabel.setAttribute("class", "form-label mt-2 mb-2");
        // Tạo ô input mới
        const newAnswerInput = document.createElement("input");
        newAnswerInput.setAttribute("type", "text");
        newAnswerInput.setAttribute("name", "question[contents][]");
        newAnswerInput.setAttribute("class", "form-control question-input");
        newAnswerInput.setAttribute("placeholder", `Nội dung câu trả lời ${answerCount + 2}`);

        // Thêm label và ô input vào container
        additionalAnswersContainer.appendChild(newAnswerLabel);
        additionalAnswersContainer.appendChild(newAnswerInput);
        answerCount += 1;
      } else {
        addAnswerButton.disabled = true;
        addAnswerButton.textContent = "Đã đạt tối đa số câu trả lời";
      }
    });
  }
});
