<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Mapharcie : Passer un Drive</title>
	<link rel="stylesheet" type="text/css" href="template/styles/style.css">
	<script type="text/javascript" src="template/scripts/script_menu.js"></script>
	<script type="text/javascript" src="template/scripts/script_star.js"></script>
</head>
<body>
	
<?php require_once("template/templates/templates_header.php"); ?>

	<div class="content">

		<form action="index.php?page=givePrescription" method="POST" enctype="multipart/form-data" class="form-submitReview">
			
			<?php

			if (isset($errors['NOT_IMG_PNG']))
				echo '<p class="error-form">Le fichier transmit n\'est pas une image PNG</p>';
			if (isset($errors['IMG_ALREADY_EXISTS']))
				echo '<p class="error-form">Le fichier transmit est déjà présent sur le serveur</p>';
			if (isset($errors['ERROR_TRANFERT_IMG']))
				echo '<p class="error-form">Une erreur c\'est produit lors du tranfert</p>';
			if (isset($errors['NO_ERROR_UPLOAD_IMG']))
				echo '<p class="success-form">Le fichier à étais uploadé avec success</p>';

			?>

			<label>Choisissez une photo de votre ordonnance</label><br />
			<input type="file" name="file" id="file" class="input-form" required /><br /><br />
			<label>Veilleur nous communiquez votre email*</label><br />
			<input type="email" name="email" class="input-form" required /><br /><br />
  			<input type="submit" value="Upload Image" name="submit" class="input-form submit-class">
		</form>

		<div class="info-formulaire">
			* : Votres adresse email est nécaissaire pour pouvoir vous identifié lorsque vous aller retirer votre commande si elle est éronner, nous allons vous faire payer mais pas vous donner la commande. En cas de dépassement du delais d'une heure execatement pour retirer votre commande, elle vous serrat aussi facturer en double pour le dédomagement. Et bien sur venir en avance ne sert a rien car la commande ne serrat pas encore faite.
		</div>

	</div>

</body>
</html>