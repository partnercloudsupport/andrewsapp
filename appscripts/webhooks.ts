//https://script.google.com/macros/s/AKfycbyahgWvy7GHdx3BADRiAVVTkQtuv7ET7ss1abd1RPS62pE6VlM/exec
function doGet(e) {
  var params = JSON.stringify(e);
  var sheet = SpreadsheetApp.getActiveSheet();
  sheet.appendRow(params);
  console.log(params);
  return params + "hi";
  // return HtmlService.createHtmlOutput(e);
}

//https://script.google.com/macros/s/AKfycbyahgWvy7GHdx3BADRiAVVTkQtuv7ET7ss1abd1RPS62pE6VlM/exec
function doPost(e) {
  var params = JSON.stringify(e);
  var sheet = SpreadsheetApp.getActiveSheet();
  sheet.appendRow(params);
  console.log(params);
  return params + "hi";
  // return HtmlService.createHtmlOutput(e);
}
