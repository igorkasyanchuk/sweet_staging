var $client_total_lines = null;
var $logs = null;
var $timer = null;
var $running = false;

$(function() {
  $timer = setInterval(fetchLogs, 1000);
  fetchLogs();

  $logs = document.getElementById("logs");
  const ps = new PerfectScrollbar($logs);
});

function fetchLogs() {
  if($running) {
    console.log("Skip fetch, too many requests.");
    return;
  }

  console.log("Fetching ....");

  var url = $(".is-active a:first").attr('changes_url');
  $running = true;

  $.ajax({
    type: "GET",
    url: url,
    data: {
      client_total_lines: $client_total_lines
    },
  }).done(function() { $running = false; });
}

function populateLogs(lines) {
  console.log(lines.length);

  var ansi_up = new AnsiUp;
  var html = "";

  lines.forEach(line => {
    html += ansi_up.ansi_to_html(line);
    html += "<br/>"
  });

  $logs.innerHTML = $logs.innerHTML + html;
  $logs.scrollTop = $logs.scrollHeight;
}

function pauseButton() {
  $('#start').toggleClass("is-hidden");
  $('#pause').toggleClass("is-hidden");
  $running = true;
}

function startButton() {
  $('#start').toggleClass("is-hidden");
  $('#pause').toggleClass("is-hidden");
  $running = false;
  fetchLogs();
}
