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
			newAnswerInput.attr("name", "question[content][]");
			newAnswerInput.attr("class", "form-control question-input");
			newAnswerInput.attr(
				"placeholder",
				`Nội dung câu trả lời ${answerCount + 2}`
			);

			// Thêm label và ô input vào container
			additionalAnswerContainer.append(newAnswerLabel);
			additionalAnswerContainer.append(newAnswerInput);
			answerCount += 1;
		} else {
			addAnswerButton.prop("disabled", true);
			addAnswerButton.text("Đã đạt tối đa số câu trả lời");
		}
	});
}

$(function() {
    // Khi thực hiện action submit để tạo question thì sẽ hiển thị answer form
    $("#question-form").on("submit", function (e) {
		e.preventDefault();
		const formData = $("#question-form").serialize();
        const actionUrl = $("#question-form").attr('action');
        $.ajax({
            url: actionUrl,
            method: 'POST',
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
})