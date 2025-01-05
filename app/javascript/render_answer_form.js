$(function() {
    $("#question-form").on('submit', function(e) {
        e.preventDefault();
        const formData = $("#question-form").serialize();
        console.log(formData);
        $.ajax({
            url: $(this).attr("action"),
            method: $(this).attr("method"),
            data: $(this).serialize(),
            success: function (response) {
                if (response.html) {
                    console.log(response.html);
					$("#answer-form").append(response.html);
				} else {
					alert("Không nhận được dữ liệu từ server!");
				}
            },
            error: function (xhr) {
                alert("Lỗi: " + xhr.responseJSON.error.join(", "));
            },
        });
    })
})