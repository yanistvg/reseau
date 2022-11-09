<?php

	require_once("fonctions/fonctions_main.php");
	require_once("fonctions/fonctions_bdd.php");

	$all_page = array(
		'accueil',		   // 0
		'submitReview',    // 1
		'givePrescription' // 2
	);

	$errors = [];

	if(!isset($_GET['page']))
		redirection('accueil');

	if($_GET['page'] == $all_page[1] && isset($_POST['submit']) && isset($_POST['email']) && isset($_POST['avis'])) {
		postReview();
	}

	if($_GET['page'] == $all_page[2] && isset($_POST['submit']) && isset($_POST['email'])) {
		$ret = postPrescription();

		if ($ret == 1)
			$errors['NOT_IMG_PNG'] = true;
		if ($ret == 2)
			$errors['IMG_ALREADY_EXISTS'] = true;
		if ($ret == 3)
			$errors['ERROR_TRANFERT_IMG'] = true;
		if ($ret == 0)
			$errors['NO_ERROR_UPLOAD_IMG'] = true;
	}

	draw_page($_GET['page'], $all_page, $errors);

?>