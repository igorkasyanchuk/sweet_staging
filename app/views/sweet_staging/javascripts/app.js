$(function() {
  var url = $(".is-active a:first").attr('changes_url');

  $.ajax({
    type: "GET",
    url: url
  });
});

function populateLogs(lines) {
  var ansi_up = new AnsiUp;
  var html = "";

  lines.forEach(line => {
    html += ansi_up.ansi_to_html(line);
    //html += "<br/>"
  });

  var div = document.getElementById("logs");
  div.innerHTML = html;

  const ps = new PerfectScrollbar(div);
  div.scrollTop = div.scrollHeight;
}

function scrollToTheBottom() {
  var div = document.getElementById("logs");
}
