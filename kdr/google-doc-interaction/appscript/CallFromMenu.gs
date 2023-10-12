// See https://docs.google.com/document/d/1ppdCke1aOmy4NZHdvdJQ7rQd32QaMezDGvFUQA1InV8/edit

const BASE_URL = "kdrsnake.kevd1337.repl.co";

// Creates a custom menu in Google Docs
function onOpen() {
  DocumentApp.getUi().createMenu("OfCounsel")
      .addItem("Check for compliance", "checkCompliance")
      .addToUi();
}

function checkCompliance() {
  const doc = DocumentApp.getActiveDocument();
  // Below is how you get copy of whatever text is currently selected
  // const selectedText = doc.getSelection().getRangeElements()[0].getElement().asText().getText();
  const body = doc.getBody();

  output = callAPI();
  // Should be { "message": "Hello World!", "status": "success" }
  Logger.log(output);
  body.appendParagraph(output.message);
}

function callAPI() {
  // Do cooler stuff
  try {
    const headers = {
      "Content-Type": "application/json",
      //"Authorization": `Bearer ${}`
    };

    const options = {
      headers,
      method: "GET",
      muteHttpExceptions: true,
      // payload: JSON.stringify({
      // })
    };

    const response = JSON.parse(UrlFetchApp.fetch(BASE_URL, options));
    return response;
  } catch (e) {
    Logger.log(e);
    return "Some Error Occured";
  }
}

