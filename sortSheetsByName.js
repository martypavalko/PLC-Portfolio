function sortSheetsByName() {
  // Build new array
  var aSheets = new Array();
  // Select active (Google Sheet) spreadsheet as ss
  var ss = SpreadsheetApp.getActiveSpreadsheet();

  // Iterate through sheets in the Google Sheet
  for (var s in ss.getSheets())
  {
      // Add to the end of the array, the name of the current sheet from each iteration
      aSheets.push(ss.getSheets()[s].getName());
  }
  // If the array is not empty
  if(aSheets.length)
  {
    // Sort the array
    aSheets.sort();
    // Reverse the order of the array
    aSheets.reverse();
    // Find index of ITEMS
    var itemIndex = aSheets.findIndex(el => el == "ITEMS");
    // Remove ITEMS from the array
    aSheets.splice(itemIndex, 1);
    // Add ITEMS as the first element of the array
    aSheets.unshift("ITEMS");

    for (var i = 0; i < aSheets.length; i++)
    {
      var theSheet = ss.getSheetByName(aSheets[i]);
      if(theSheet.getIndex() != i + 1)
      {
        ss.setActiveSheet(theSheet);
        ss.moveActiveSheet(i + 1);
      }
    }
  }
}