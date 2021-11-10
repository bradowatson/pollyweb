<html lang="en" dir="ltr">

<head>
	<link rel="icon" type="image/png" href="./images/favicon.ico">
	<title>Octank Trade Desk</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="./includes/styles/layout.css" type="text/css" />
	<script src="./includes/js/url.min.js"></script>
	<script type="text/javascript">

		function requestEnglish() {
			var text = document.getElementById("english").value;
			pollyRequest(text, "Joanna");
		}

		function pollyRequest(text, name) {
			url = "./polly.jsp?name=" + name + "&text=" + text;
			audioObj = new Audio(url);
		}

		function requestSpanish() {
			var text = document.getElementById("spanish").value;
			pollyRequest(text, "Penelope");
		}
	</script>
</head>

<body>
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
					<textarea id="english" name="english" rows="6" cols="50" style="font-size: 16pt"></textarea>
				</td>
				<td style="padding:10px">
					<textarea id="spanish" name="spanish" rows="6" cols="50" style="font-size: 16pt"></textarea>
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
					<button class="button recordedbutton" onclick="pollyRequest('Hello and thanks for calling! How may I assist you today?', 'Joanna')">Hello</button>
					<button class="button recordedbutton" onclick="pollyRequest('Thank you for calling! Have a great day!', 'Joanna')">Goodbye</button>
					<button class="button recordedbutton" onclick="pollyRequest('If you don\'t mind I\'m going to place you on a brief hold.', 'Joanna')">Hold</button>
				</td>
				<td align="right" style="padding:10px">
					<button class="button recordedbutton" onclick="pollyRequest('¡Hola y gracias por llamar! ¿Cómo puedo ayudarte hoy?', 'Penelope')">Hola</button>
					<button class="button recordedbutton" onclick="pollyRequest('¡Gracias por llamar! ¡Qué tengas un lindo día!', 'Penelope')">Adios</button>
					<button class="button recordedbutton" onclick="pollyRequest('si no te importa te voy a poner en una breve espera', 'Penelope')">Espere</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="wrapper row4">
		<footer id="copyright" class="clear">
			<p class="fl_left">&nbsp; Copyright &copy; 2021 - Amazon Web Services - All Rights Reserved</p>
			<p class="fl_right">AWS Sound Board &nbsp;</a>
			</p>
		</footer>
	</div>
</body>

</html>