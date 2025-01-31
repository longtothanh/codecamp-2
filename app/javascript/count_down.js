$(function () {
  const durationInMinutes = 15;
  const timerDisplay = $("#timer");
  const form = $("#do_test");

  if (!timerDisplay.length || !form.length) {
    return;
  }

  const timerKey = `test_timer_${form.data("test-id")}`;

  let timeRemaining = parseInt(localStorage.getItem(timerKey), 10) || durationInMinutes * 60;

  function updateTimerDisplay() {
    const minutes = Math.floor(timeRemaining / 60);
    const seconds = timeRemaining % 60;
    timerDisplay.text(`${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`);
  }

  const countdown = setInterval(function () {
    if (timeRemaining > 0) {
      timeRemaining -= 1;

      localStorage.setItem(timerKey, timeRemaining);

      updateTimerDisplay();
    } else {
      clearInterval(countdown);
      localStorage.removeItem(timerKey);
      alert("Hết giờ! Bài kiểm tra sẽ được nộp tự động.");
      form.submit();
    }
  }, 1000);

  updateTimerDisplay();

  form.on("submit", function () {
    localStorage.removeItem(timerKey);
    clearInterval(countdown);
  });

  $("#back-to-user-dashboard").on("click", function () {
    alert("Bạn có muốn quay về trang dashboard không? Bài kiểm tra không được lưu lại!");
    localStorage.removeItem(timerKey);
    clearInterval(countdown);
  });
});
