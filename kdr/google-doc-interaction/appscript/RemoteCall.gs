const BASE_URL = "kdrsnake.kevd1337.repl.co";

function callAPI() {
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
    console.log(e)
    return "Some Error Occured";
  }
}


function testAPI() {
    console.log('my testA function')
    output = callAPI();
    console.log(output);
}
