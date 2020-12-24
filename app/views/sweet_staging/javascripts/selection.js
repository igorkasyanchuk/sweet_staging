function getSelectionText(){
  var selectedText = ""
  if (window.getSelection){ // all modern browsers and IE9+
      selectedText = window.getSelection().toString()
  }
  return selectedText;
}

document.addEventListener('mouseup', function(){
  var thetext = getSelectionText()
  if (thetext.length > 0) { // check there's some text selected
      console.log(thetext);
      document.execCommand("copy"); // logs whatever textual content the user has selected on the page
  }
}, false);