$(function () {
  const durationInMinutes = 15;
  const timerDisplay = $("#timer");
  const form = $("#do_test");

  if (!timerDisplay.length || !form.length) {
    return;
  }

  let timeRemaining = durationInMinutes * 60;

  function updateTimerDisplay() {
    const minutes = Math.floor(timeRemaining / 60);
    const seconds = timeRemaining % 60;
    timerDisplay.text(`${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`);
  }

  const countdown = setInterval(function () {
    if (timeRemaining > 0) {
      timeRemaining -= 1;
      updateTimerDisplay();
    } else {
      clearInterval(countdown);
      alert("Hết giờ! Bài kiểm tra sẽ được nộp tự động.");
      form.submit();
    }
  }, 1000);

  updateTimerDisplay();
});
