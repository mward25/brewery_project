/*
 * This file provides basic methods used in brew.html
 * */

// Constants
const SERVER_URL = "https://localhost:44344/api/";
const RECIPIES = "recipes/";
const BATCHES = "batches/";
const STYLE = "styles/"
const GET_INSTRUCT = "GET";
const POST_INSTRUCT = "POST";
const PUT_INSTRUCT = "PUT";
const DELETE_INSTRUCT = "DELETE";
const HEADER_VALUE = "*";
const HEADER = "Access-Control-Allow-Origin" + ": " + HEADER_VALUE;

const PAGE_NOT_FOUND_REFERENCE_START = "<a href=page_not_found.html>";
const PAGE_NOT_FOUND_END = "</a>";

// These are parallel arrays
var outputBatches = [];
var brewNowOutputBatches = []; // used to store brew now checkbox values
var deleteBatches = []; // used to store deleteBatch checkbox values

// This array is used for caching the recipes
var recipeArray = [];

function GenerateTables()
{
	GenerateRecipeTable();
	GenerateBatchesTable();
}

function SearchBarWork(searchQuery)
{
	console.log("running function SearchBarWork");
	var sortedRecipeArray = recipeArray.sort(
			(theRecipe) => {
				var theString = theRecipe.name.toLowerCase();
				var styleString = theRecipe.style.name.toLowerCase();
				console.log("theRecipe.style.name=" + theRecipe.style.name);
				// filter by name and style
				//if (theString.substr(0, searchQuery.length) == searchQuery.toLowerCase() || ( theRecipe.style !== undefined && searchQuery.toLowerCase() == theRecipe.style.name.toLowerCase().substr(0, searchQuery.length) ))
				
				var theStringResult = theString.indexOf(searchQuery.toLowerCase()); 
				var styleStringResult = styleString.indexOf(searchQuery.toLowerCase());

				if (theStringResult > -1)
				{
					console.log("in sort function, they were the same, returning 1");
					return (Number.MAX_SAFE_INTEGER)/(theStringResult+1);
				}
				else if (styleStringResult > -1)
				{
					return (Number.MAX_SAFE_INTEGER)/(styleStringResult+1);
				}
				else
				{
					console.log("they were not the same, returning 0");
					return 0;
				}
				
			}
		)

	GenerateRecipeTableFromArray(sortedRecipeArray);
}

function SaveChangesToDataBase()
{
	for (let i = 0; i < outputBatches.length; i++)
	{
		if (brewNowOutputBatches[i] == true)
		{
			if (outputBatches[i].scheduledStartDate == undefined || outputBatches[i].scheduledStartDate == null)
			{
				alert("StartDate on batch " + outputBatches[i].name + " was not set");
			}
			SaveBatchToDataBase(outputBatches[i]);
		}
		else if (deleteBatches[i] == true)
		{
			DeleteBatchFromDataBase(outputBatches[i]);
		}
	}
	alert("finished saving changes");
}

function DeleteBatchFromDataBase(theBatch)
{
	if (theBatch.batchId !== null || theBatch.batchId !== undefined)
	{
		var theBatchDestroyer = new XMLHttpRequest();
		theBatchDestroyer.open(DELETE_INSTRUCT, SERVER_URL + BATCHES + theBatch.batchId);
		theBatchDestroyer.setRequestHeader('Content-type', 'application/json');
		theBatchDestroyer.send();
	}
}

// Note: if the batch already exists the function will just update the batch
function SaveBatchToDataBase(theBatch)
{
	var theBatchSaver = new XMLHttpRequest();

	if (theBatch.batchId == null || theBatch.batchId == undefined)
	{
		theBatchSaver.open(POST_INSTRUCT, SERVER_URL + BATCHES);
		theBatchSaver.setRequestHeader('Content-type', 'application/json');
		theBatchSaver.send(JSON.stringify(theBatch));
		theBatchSaver.onload = function() {
			//alert(theBatchSaver.response);
			theBatch.batchId = JSON.parse(theBatchSaver.response).batchId;
		}
	}
	else
	{
		theBatchSaver.open(PUT_INSTRUCT, SERVER_URL + BATCHES + theBatch.batchId);
		theBatchSaver.setRequestHeader('Content-type', 'application/json');
		theBatchSaver.send(JSON.stringify(theBatch));
	}
}


// I got this function from Andy E on https://stackoverflow.com/questions/3075577/convert-mysql-datetime-stamp-into-javascripts-date-format
Date.createFromMysql = function(mysql_string) 
{ 
	var t, result = null;

	if( typeof mysql_string === 'string' )
	{
		console.log("running function createFromMysql, mysql_string="  + mysql_string);
		const tmpRegex = /T/;
		var tmpSqlString = mysql_string.substr(0, mysql_string.search(tmpRegex));
		console.log("in createFromMysql, tmpSqlString=", tmpSqlString);
		t = tmpSqlString.split(/[- :]/);
		//when t[3], t[4] and t[5] are missing they defaults to zero
		result = new Date(t[0], t[1] - 1, t[2], t[3] || 0, t[4] || 0, t[5] || 0);          
		console.log("in createFromMysql, result=" + result.toString());
	}

	return result;   
}

function JavaScriptDateToMySqlDate(inputDate)
{
	// got this from Gajus on https://stackoverflow.com/questions/5129624/convert-js-date-time-to-mysql-datetime/5133807
	return inputDate.toISOString().slice(0, 19).replace('T', ' ');
}

function GetLatestDate(inputRecipe)
{
	console.log("batches=" + inputRecipe.batches.length);
	var returnValue;
	theDataData = inputRecipe.batches;
	if ( !(theDataData.length <= 0) ) 
	{
		importantData = [];
		for (let i = 0; i < theDataData.length; i++)
		{
			importantData.push(Date.createFromMysql(theDataData.finishDate));
		}

		if (importantData !== undefined)
		{
			//if (importantData[0] !== undefined)
			//{
			//	var shortestData = importantData[0];
			//}
			var shortestData = null;
			for (let i = 1; i < importantData.length; i++)
			{
				console.log("importantData[i]=" + importantData[i].toString());
				if (shortestData == null)
				{
					shortestData = importantData[i];
				}
				if (importantData[i] !== undefined && importantData[i] > shortestData)
				{
					shortestData = importantData[i];
				}
			}
			returnValue = shortestData;
		}
	}
	else
	{
		returnValue = "no date found";
	}
	console.log("returnValue=" + returnValue);
	return returnValue;
}

function GetRemoteVar(serverUrl, query)
{
	var theData= new XMLHttpRequest();
	var returnValue;
	theData.open(GET_INSTRUCT, serverUrl + query, false);
	theData.setRequestHeader('Access-Control-Allow-Origin', 'SERVER_URL');
	theData.setRequestHeader('Content-type', 'application/json');
	theData.send();

	returnValue = JSON.parse(theData.response);
	console.log("returnValue is " + returnValue.name);
	return returnValue;
}

function GenerateRecipeTable() 
{
	var theTable = document.getElementById("nonScheduledBrewsTable");
	var theData = new XMLHttpRequest();

	if (recipeArray.length <= 0)
	{
		//theData.Header = HEADER;
		theData.open(GET_INSTRUCT, SERVER_URL + RECIPIES);
		//theData.setRequestHeader('X-Requested-With', 'XMLHttpRequest'); 
		theData.setRequestHeader('Access-Control-Allow-Origin', 'SERVER_URL');
		//Access-Control-Allow-Origin
		//theData.setRequestHeader("Sec-Fetch-Mode", "no-cors");
		theData.setRequestHeader('Content-type', 'application/json');
		theData.send();
		theData.onload = (e) => {
			//console.log(theDataResponce.response);
			var theDataResponce = JSON.parse(theData.response);
			recipeArray = theDataResponce;
			console.log("code reached after for loop");
			GenerateRecipeTableFromArray(theDataResponce);
		}
	}
	else
	{
		GenerateRecipeTableFromArray(recipeArray);
	}
}
	
function GenerateRecipeTableFromArray(theDataResponce)
{
	console.log("code reached before for loop");
	console.log("theDataResponce.length=" + theDataResponce.length);
	var theTable = document.getElementById("nonScheduledBrewsTable");
	
	console.log("running function GenerateRecipeTableFromArray");
	while (theTable.rows.length > 1)
	{
		console.log("deleting " + theTable.style.height + " row in GenerateRecipeTableFromArray");
		theTable.deleteRow(-1);
	}


	for (let i = 0; i < theDataResponce.length; i++)
	{
		console.log("code reached inside for loop");
		console.log("ran for loop " + i + " times");
		var theRow = theTable.insertRow(1);

		var versionCell             = theRow.insertCell(-1);
		var nameCell                = theRow.insertCell(-1);
		var styleCell               = theRow.insertCell(-1);
		var ibuCell                 = theRow.insertCell(-1);
		var abvCell                 = theRow.insertCell(-1);
		var ingredientsCell         = theRow.insertCell(-1);
		var lastBrewedCell          = theRow.insertCell(-1);
		var inventoryCell           = theRow.insertCell(-1);
		var addToScheduledBrewsCell = theRow.insertCell(-1);

		var recipeStyle;
		// if the style is already set in the recipe, just set recipeStyle to theDataResponce[i], otherwise get the style
		if (theDataResponce[i].style == undefined || theDataResponce[i].style == null)
		{
			recipeStyle = GetRemoteVar(SERVER_URL, STYLE + theDataResponce[i].styleId);
		}
		else
		{
			recipeStyle = theDataResponce[i].style;
		}

		console.log("recipe.styleId=" + theDataResponce[i].styleId + " recipeStyle=" + (recipeStyle == undefined || recipeStyle == null ? "does not exist" : recipeStyle.name));
		theDataResponce[i].style = recipeStyle;
		versionCell           .innerHTML = theDataResponce[i].version; 
		nameCell              .innerHTML = theDataResponce[i].name + "</a>";
		if (recipeStyle !== undefined)
		{
			styleCell             .innerHTML = recipeStyle.name; 
			ibuCell               .innerHTML = recipeStyle.ibuMin;
			abvCell               .innerHTML = recipeStyle.abvMin;
		}
		
		ingredientsCell        .innerHTML = PAGE_NOT_FOUND_REFERENCE_START + "ingredients" + PAGE_NOT_FOUND_END;
		var latestDate = theDataResponce[i].date;
		if (typeof latestDate === 'string')
		{
		}
		else if (typeof latestDate === 'Date')
		{
			latestDate = latestDate.toString();
		}
		else if (latestDate == null)
		{
			latestDate = "never brewed";
		}
		console.log("latestDate=" + latestDate);
		lastBrewedCell         .innerHTML = latestDate;
		inventoryCell          .innerHTML = PAGE_NOT_FOUND_REFERENCE_START + "inventory" + PAGE_NOT_FOUND_END;
		addToScheduledBrewsCell.innerHTML = "<button onclick=\"AddBatchFromRecipeId(" + theDataResponce[i].recipeId + ")\"> add to brew </button>";
	}
}

function AddBatchFromRecipeId(theId)
{
	var theRecipe = GetRemoteVar(SERVER_URL, RECIPIES + theId);
	var theStyle = GetRemoteVar(SERVER_URL, STYLE + theRecipe.recipeId);
	var today = new Date();

	// define theBatch
	var theBatch = {
		//"batchId": null,
		"recipeId": theRecipe.recipeId,
		"equipmentId": theRecipe.equipmentId,
		"volume": theRecipe.volume,
		"scheduledStartDate": "1000-01-01",
		"startDate": null,
		"estimatedFinishDate": null,
		"finishDate": null,
		"unitCost": 0,
		"notes": theStyle.notes,
		"tasteNotes": "not yet entered",
		"tasteRating": 0,
		"og": theStyle.ogMin,
		"fg": theStyle.fgMin,
		"carbonation": theStyle.carbMin,
		"fermentationStages": 0,
		"primaryAge": 0,
		"primaryTemp": 0,
		"secondaryAge": 0,
		"secondaryTemp": 0,
		"tertiaryAge": 0,
		"age": 0,
		"temp": theRecipe.temp,
		"ibu": theStyle.ibuMin,
		"ibuMethod": "not yet determined",
		"abv": theStyle.abvMin,
		"actualEfficiency": theRecipe.actualEfficiency,
		"calories": theRecipe.calories,
		"carbonationUsed": "not yet determined",
		"forcedCarbonation": 0,
		"kegPrimingFactor": 0,
		"carbonationTemp": 0,
		"equipment": null,
		"recipe": null,
		"batchContainers": [],
		"ingredientInventorySubtractions": [],
		"inventoryTransactions": [],
		"products": []
	};
	AddBatch(theBatch);
}

function AddBatch(theBatch)
{
	console.log("running function addBatch");

	if (theBatch == undefined || theBatch == null)
	{
		return;
	}
	else
	{
		var theRecipe = GetRemoteVar(SERVER_URL, RECIPIES + theBatch.recipeId);
		var recipeStyle = GetRemoteVar(SERVER_URL, STYLE + theRecipe.styleId);
		
		

		outputBatches.push(theBatch);
		brewNowOutputBatches.push(false);
		deleteBatches.push(false);
		var insertedLocation = outputBatches.length-1;
		
		var theTable = document.getElementById("batchesTable");
		var theRow = theTable.insertRow(-1);


		var Name = theRow.insertCell(-1);
		var Style = theRow.insertCell(-1);
		var IBU = theRow.insertCell(-1);
		var ABV = theRow.insertCell(-1);
		var Recipe = theRow.insertCell(-1);
		var Inventory = theRow.insertCell(-1);
		var BrewNow = theRow.insertCell(-1);
		var ScheduleABrew = theRow.insertCell(-1);
		var DeleteBatch = theRow.insertCell(-1);
		
		Name       .innerHTML = theRecipe.name;
		Style      .innerHTML = recipeStyle.name;
		IBU        .innerHTML = recipeStyle.ibuMin;
		ABV        .innerHTML = recipeStyle.abvMin;
		Recipe     .innerHTML = PAGE_NOT_FOUND_REFERENCE_START + "recipe" + PAGE_NOT_FOUND_END;
		Inventory  .innerHTML = PAGE_NOT_FOUND_REFERENCE_START + "inventory" + PAGE_NOT_FOUND_END;
		var scheduledDate = Date.createFromMysql(theBatch.scheduledStartDate);
		BrewNow.innerHTML = "<input type=checkbox onchange=\"if (this.checked) {updateBatchBrewNow( " + insertedLocation + ",true)} else {  updateBatchBrewNow( " + insertedLocation + ", false)}\">Brew now</input>";

		// Set date to date stored in database
		var theDate = scheduledDate.getDate() + 1;
		if (theDate < 10)
		{
			theDate = '0' + theDate;
		}
		var theMonth = scheduledDate.getMonth()+1;
		if (String(theMonth).length < 2)
		{
			theMonth = '0' + theMonth;
		}
		var theYear = scheduledDate.getFullYear();

		theDate = String(theDate);
		theMonth = String(theMonth);
		theYear = String(theYear);
		ScheduleABrew.innerHTML = "<input type=date value=\"" + theYear + "-" + theMonth + "-" + theDate + "\" onchange=\"updateBatchDate(" + insertedLocation + ", this.value)\">Schedule a brew:</input>";
		DeleteBatch.innerHTML = "<input type=checkbox onchange=\"if (this.checked) {updateBatchDeleteBatch( " + insertedLocation + ",true)} else {  updateBatchDeleteBatch( " + insertedLocation + ", false)}\">DeleteBatch</input>";
		var latestDate;
		if (theRecipe.date == null)
		{
			latestDate = "never brewed";
		}
		else
		{
			latestDate = theRecipe.date;
		}
		console.log("latestDate=" + latestDate);
		
		//LastBrewed.innerHTML = latestDate;
		//Inventory.innerHTML = PAGE_NOT_FOUND_REFERENCE_START + "inventory" + PAGE_NOT_FOUND_END;
	}
}

function updateBatchDate(theArrayIndex, value)
{
	console.log("running function updateBatchDate");
	outputBatches[theArrayIndex].scheduledStartDate = value;
	console.log("outputBatches[theArrayIndex].scheduledStartDate=" + outputBatches[theArrayIndex].scheduledStartDate);
}

function updateBatchBrewNow(theArrayIndex, value)
{
	
	console.log("running function updateBatchBrewNow");
	brewNowOutputBatches[theArrayIndex] = value;
	console.log("brewNowOutputBatches[theArrayIndex]=" + brewNowOutputBatches[theArrayIndex]);
}

function updateBatchDeleteBatch(theArrayIndex, value)
{
	console.log("running function updateBatchDeleteBatch");
	deleteBatches[theArrayIndex] = value;
	console.log("deleteBatches[theArrayIndex]=" + deleteBatches[theArrayIndex]);
}

function GenerateBatchesTable()
{
	console.log("running function GenerateBatchesTable");
	var batches = GetRemoteVar(SERVER_URL, BATCHES);
	console.log("batches.length=" + batches.length);

	for (let i = 0; i < batches.length; i++)
	{
		AddBatch(batches[i]);
	}
	console.log("finishing function GenerateBatchesTable");
}



// Useless Comments
//	//Build an array containing Customer records.
//	var customers = new Array();
//	customers.push(["Customer Id", "Name", "Country"]);
//	customers.push([1, "John Hammond", "United States"]);
//	customers.push([2, "Mudassar Khan", "India"]);
//	customers.push([3, "Suzanne Mathews", "France"]);
//	customers.push([4, "Robert Schidner", "Russia"]);
//	
//	//Create a HTML Table element.
//	var table = document.createElement("TABLE");
//	table.border = "1";
//	
//	//Get the count of columns.
//	var columnCount = customers[0].length;
//	
//	//Add the header row.pe
//	var row = table.insertRow(-1);
//	for (var i = 0; i < columnCount; i++) 
//	{
//		var headerCell = document.createElement("TH");
//		headerCell.innerHTML = customers[0][i];
//		row.appendChild(headerCell);
//	}
//	
//	//Add the data rows.
//	for (var i = 1; i < customers.length; i++) 
//	{
//		row = table.insertRow(-1);
//		for (var j = 0; j < columnCount; j++) 
//		{
//			var cell = row.insertCell(-1);
//			cell.innerHTML = customers[i][j];
//		}
//	}
//		
//		var dvTable = document.getElementById("dvTable");
//		dvTable.innerHTML = "";
//		dvTable.appendChild(table);
	
