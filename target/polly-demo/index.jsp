
<%@page import="com.watson.dynamodb.DBHelper"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.Item"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.ItemCollection"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.ScanOutcome"%>
<%@page import="java.util.Iterator"%>

<%
	if(request.getParameter("name") != null) {
		DBHelper.addItem(request.getParameter("name"), request.getParameter("type"), request.getParameter("phrase"), request.getParameter("language"));
	}
   
%>

<html lang="en" dir="ltr">

<head>
	<link rel="icon" type="image/png" href="./images/favicon.ico">
	<title>AWS Sound Board</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="./includes/styles/layout.css" type="text/css" />
	<script src="./includes/js/url.min.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body onload="loadMacros()">
	<div class="wrapper row1">
		<header id="header" class="clear">
			<div id="hgroup">
				<table align="center">
					<tr>
						<td align="left" style="padding:10px"><img src="includes/images/aws.png" width="202" height="73"></td>
						<td align="right" style="padding:10px; font-family: Arial, Helvetica, sans-serif; color: white;"><h1>Text to Speech Sound Board</h1></td>
						<td></td>
                    </tr>
				</table>
			</div>
		</header>
	</div>
	<div id="homepage">
		<table align="center">
			<tr>
				<th style="padding:10px; color: white;">English Text to Speech:</th>
				<th style="padding:10px; color: white;">Spanish Text to Speech:</th>
			</tr>
			<tr>
				<td style="padding:10px">
					<textarea id="english" name="english" rows="6" cols="50" style="font-size: 16pt" onkeydown="if (event.keyCode == 13) { requestEnglish(); }"></textarea>
				</td>
				<td style="padding:10px">
					<textarea id="spanish" name="spanish" rows="6" cols="50" style="font-size: 16pt" onkeydown="if (event.keyCode == 13) { requestSpanish(); }"></textarea>
				</td>
			</tr>
			<tr>
				<td align="left" style="padding:10px">
					<button class="button submitbutton" onclick="requestEnglish()">English</button>
				</td>
				<td align="right" style="padding:10px">
					<button class="button submitbutton" onclick="requestSpanish()">Spanish</button>
				</td>
			</tr>
			<tr>
				<td align="left" style="padding:10px">
<%
	ItemCollection<ScanOutcome> items = DBHelper.getResults();
	Iterator<Item> iter = items.iterator();
	while (iter.hasNext()) {
	    Item item = iter.next();
	    if(item.getString("Type").equalsIgnoreCase("Button") && item.getString("Language").equalsIgnoreCase("English")) {
	    	String button = "<button class=\"button recordedbutton\" onclick=\"pollyRequest('" + item.getString("Phrase") + "', 'Joanna')\">" + item.getString("Name") + "</button>";
	    	out.println(button);
	    }
	}
%>
				</td>
				<td align="right" style="padding:10px">
<%
	iter = items.iterator();
	while (iter.hasNext()) {
	    Item item = iter.next();
	    if(item.getString("Type").equalsIgnoreCase("Button") && item.getString("Language").equalsIgnoreCase("Spanish")) {
	    	String button = "<button class=\"button recordedbutton\" onclick=\"pollyRequest('" + item.getString("Phrase") + "', 'Penelope')\">" + item.getString("Name") + "</button>";
	    	out.println(button);
	    }
	}
%>
				</td>
			</tr>
			<tr>
				<td align="left" style="padding:10px">
					<button class="open-button" onclick="openForm('englishButton')">New English Button</button>
					<button class="open-button" onclick="openForm('englishMacro')">New English Macro</button>
				</td>
				<td align="right" style="padding:10px">
					<button class="open-button" onclick="openForm('spanishButton')">New Spanish Button</button>
					<button class="open-button" onclick="openForm('spanishMacro')">New Spanish Macro</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="wrapper row4">
		<footer id="copyright" class="clear">
			<p class="fl_left">&nbsp; Copyright &copy; 2021 - Amazon Web Services - All Rights Reserved</p>
			<p class="fl_right">AWS Sound Board &nbsp;</p>
		</footer>
	</div>
	
	<div class="form-popup" id="englishButton">
	  <form action="./index.jsp" class="form-container" method="POST">
	    <h1>New English Button</h1>
	
	    <label for="Name"><b>Button Name</b></label>
	    <input type="text" placeholder="Enter button name" name="name" required>
	
	    <label for="Phrase"><b>Button Phrase</b></label>
	    <input type="text" placeholder="Enter button phrase" name="phrase" required>
	    <input type="hidden" name="language" value="English">
	    <input type="hidden" name="type" value="Button">
	
	    <button type="submit" class="btn">Submit</button>
	    <button type="button" class="btn cancel" onclick="closeForm('englishButton')">Cancel</button>
	  </form>
	</div>
	
	<div class="form-popup" id="spanishButton">
	  <form action="./index.jsp" class="form-container" method="POST">
	    <h1>New Spanish Button</h1>
	
	    <label for="Name"><b>Button Name</b></label>
	    <input type="text" placeholder="Enter button name" name="name" required>
	
	    <label for="Phrase"><b>Button Phrase</b></label>
	    <input type="text" placeholder="Enter button phrase" name="phrase" required>
	    <input type="hidden" name="language" value="spanish">
	    <input type="hidden" name="type" value="Button">
	
	    <button type="submit" class="btn">Submit</button>
	    <button type="button" class="btn cancel" onclick="closeForm('spanishButton')">Cancel</button>
	  </form>
	</div>
	
	<div class="form-popup" id="englishMacro">
	  <form action="./index.jsp" class="form-container" method="POST">
	    <h1>New English Macro</h1>
	
	    <label for="Name"><b>Macro Abbreviation</b></label>
	    <input type="text" placeholder="Enter abbrevation" name="name" required>
	
	    <label for="Phrase"><b>Macro Phrase</b></label>
	    <input type="text" placeholder="Enter full phrase" name="phrase" required>
	    <input type="hidden" name="language" value="English">
	    <input type="hidden" name="type" value="Macro">
	
	    <button type="submit" class="btn">Submit</button>
	    <button type="button" class="btn cancel" onclick="closeForm('englishMacro')">Cancel</button>
	  </form>
	</div>
	
	<div class="form-popup" id="spanishMacro">
	  <form action="./index.jsp" class="form-container" method="POST">
	    <h1>New Spanish Macro</h1>
	
	    <label for="Name"><b>Macro Abbreviation</b></label>
	    <input type="text" placeholder="Enter abbrevation" name="name" required>
	
	    <label for="Phrase"><b>Macro Phrase</b></label>
	    <input type="text" placeholder="Enter full phrase" name="phrase" required>
	    <input type="hidden" name="language" value="spanish">
	    <input type="hidden" name="type" value="Macro">
	
	    <button type="submit" class="btn">Submit</button>
	    <button type="button" class="btn cancel" onclick="closeForm('spanishMacro')">Cancel</button>
	  </form>
	</div>
	
	<script>

		let englishMacros = "";
		let spanishMacros = "";
		
		function requestEnglish() {
			macroEnglish();
			var text = document.getElementById("english").value;
			pollyRequest(text, "Joanna");
			document.getElementById("english").value = "";
		}

		function pollyRequest(text, name) {
			url = "./polly.jsp?name=" + name + "&text=" + text;
			audioObj = new Audio(url);
		}

		function requestSpanish() {
			macroSpanish();
			var text = document.getElementById("spanish").value;
			pollyRequest(text, "Penelope");
			document.getElementById("spanish").value = "";
		}
		
		function loadMacros() {
			getJSONData("English", loadEnglish);
			getJSONData("Spanish", loadSpanish);
		}
		
		function getJSONData(language, cFunction) {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if(this.readyState == 4 && this.status == 200) {
					cFunction(this.responseText);
				}
			};
			xhttp.open("GET", "./DynamoDB.jsp?language=" + language, true);
            xhttp.setRequestHeader('Accept', 'application/json');
			xhttp.send();
		}
		
		function loadEnglish(xhttp) {
			xhttp = xhttp.trim();
			if(xhttp.length > 1) {
				englishMacros = JSON.parse(xhttp);
			}
		}
		
		function loadSpanish(xhttp) {
			xhttp = xhttp.trim();
			if(xhttp.length > 1) {
				spanishMacros = JSON.parse(xhttp);
			}
		}

		function openForm(elementId) {
			document.getElementById(elementId).style.display = "block";
		}
		
		function closeForm(elementId) {
			document.getElementById(elementId).style.display = "none";
		}

		function repl(text, find, rep) {
			var regex = new RegExp('\\b' + find + '\\b', "gi");
			return text.replace(regex, rep);
		}
		
		function macroEnglish() {
			var text = document.getElementById("english").value;
			for (var i = 0; i < englishMacros.results.length; i++) {
				var name = englishMacros.results[i].Name;
				var phrase = englishMacros.results[i].Phrase;
				text = repl(text, name, phrase);
			}
			document.getElementById("english").value = text;
		}

		function macroSpanish() {
            var text = document.getElementById("spanish").value;
            for (var i = 0; i < spanishMacros.results.length; i++) {
				var name = spanishMacros.results[i].Name;
				var phrase = spanishMacros.results[i].Phrase;
				text = repl(text, name, phrase);
            }
            document.getElementById("spanish").value = text;
        }
		
		function submitOnEnter(event){
		    if(event.which === 13){
		        event.target.form.dispatchEvent(new Event("submit", {cancelable: true}));
		        event.preventDefault(); // Prevents the addition of a new line in the text field (not needed in a lot of cases)
		    }
		}
		
	</script>
</body>

</html>