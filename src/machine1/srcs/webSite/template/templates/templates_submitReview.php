<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Mapharcie : Soumettre mon avis</title>
	<link rel="stylesheet" type="text/css" href="template/styles/style.css">
	<script type="text/javascript" src="template/scripts/script_menu.js"></script>
	<script type="text/javascript" src="template/scripts/script_star.js"></script>
</head>
<body>
	
<?php require_once("template/templates/templates_header.php"); ?>

	<div class="content">

		<form method="POST" action="index.php?page=submitReview" class="form-submitReview">

			<div class="stars">
				<input type="checkbox" class="star-icon" id="star1" name="star1" checked />
				<label for="star1" onclick="changeStarView(0)" class="star-view valid-star">☆</label>

				<input type="checkbox" class="star-icon" id="star2" name="star2" />
				<label for="star2" onclick="changeStarView(1)" class="star-view">☆</label>

				<input type="checkbox" class="star-icon"id="star3" name="star3" />
				<label for="star3" onclick="changeStarView(2)" class="star-view">☆</label>

				<input type="checkbox" class="star-icon"id="star4" name="star4" />
				<label for="star4" onclick="changeStarView(3)" class="star-view">☆</label>

				<input type="checkbox" class="star-icon"id="star5" name="star5" />
				<label for="star5" onclick="changeStarView(4)" class="star-view">☆</label>
			</div>

			<label>Donner votre avis</label><br />
			<textarea name="avis" class="text-area"></textarea><br />

			<label>Renseigner votre-email*</label><br />
			<input type="email" name="email" class="input-form" required /><br /><br />
			
			<input type="submit" name="submit" value="donner mon avis" class="input-form submit-class" />

		</form>

		<div class="info-formulaire">
			* : Votres adresse email est nécaissaire pour pouvoir vous envoyer un mail d'excuse en cas d'un mauvais avis. Nous allons répondre de manière très poli avec des excuses que nous ne pensons pas mais que nous sommes obligé de faire pour la bonne image de notres entreprise.
		</div>

	</div>

</body>
</html>