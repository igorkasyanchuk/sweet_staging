var $client_total_lines = null;
var $logs = null;
var $timer = null;
var $running = false;
var $pause = false;
var $console = null;

$(function() {
  $('#input').keydown(function (e) {
    if (e.ctrlKey && e.keyCode == 13) {
      executeConsole();
    }
  });
});

function logsWorkerInit() {
  $timer = setInterval(fetchLogs, FETCH_TIMEOUT);
  fetchLogs();
  $logs = document.getElementById("logs");
}

function consoleWorkerInit() {
  $console = document.getElementById("console");

  document.getElementById("input").focus();
}

function commandsWorkerInit() {
  $commands = document.getElementById("command-output");
  $commands.scrollTop = $commands.scrollHeight;
}

function fetchLogs() {
  if ($pause) {
    console.log("On pause.");
    return;
  }

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

  keyboardJS.bind('p', (e) => {
    $pause = true;
    pauseButton();
  });

  keyboardJS.bind('s', (e) => {
    $pause = false;
    startButton();
  });

  keyboardJS.bind('c', (e) => {
    console.log('c');
    clearButton();
  });

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
  $('#three-dots').addClass("is-hidden");
  $running = true;
  $pause = true;
}

function startButton() {
  $('#start').toggleClass("is-hidden");
  $('#pause').toggleClass("is-hidden");
  $('#three-dots').removeClass("is-hidden");
  $running = false;
  $pause = false;
  fetchLogs();
}

function clearButton() {
  $($logs).empty();
  return false;
}

function executeConsole() {
  var url = $("#input").attr("url");
  $.ajax({
    type: "POST",
    url: url,
    data: {
      code: $("#input").val()
    },
  }).done(function() { $running = false; });

  $('.loader-wrapper').show();
  $('#console').addClass('hidden');
}

function populateResults(code, html) {
  html = html.replace(/\&quot\;/g, '');

  $console.innerHTML = $console.innerHTML + '<div class=\'code\'>' + code + '</div>';

  $console.innerHTML = $console.innerHTML + html;
  $console.scrollTop = $console.scrollHeight;

  $('.code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
}
